# frozen_string_literal: true

require 'oystercard'
describe Oystercard do
let(:station){double(:station)}
let(:entry_station){double(:station)}
let(:exit_station){double(:station)}

  it { is_expected.to respond_to(:in_journey?) }

  describe '#balance' do
    it 'has an initial balance 0' do
      expect(subject.balance).to eq 0
    end
  end
  describe '#top_up' do
    it 'adds money to the card' do
      subject.top_up(5)
      expect(subject.balance).to eq 5
    end

    describe '#in_journey?' do
      it 'is initially not in a journey' do
        expect(subject.in_journey?).to eq false
      end
    end

    describe '#touch_in' do
      it 'starts a journey' do
        subject.top_up(5)
        subject.touch_in(station)
        expect(subject.in_journey?).to eq true
      end
      it "remembers the entry station" do
        subject.top_up(5)
        subject.touch_in(station)
        expect(subject.entry_station).to eq station
      end

    end

    describe '#touch_out' do
      it 'ends the journey' do
        subject.touch_out(station)
        expect(subject.in_journey?).to eq false
      end
      it 'deducts the min fare from balance' do
        min_fare = Oystercard::MINIMUM_FARE
        subject.top_up(5)
        expect {subject.touch_out(station)}.to change {subject.balance}.by(- min_fare)
      end
      it 'resets the entry station' do
        subject.top_up(5)
        subject.touch_in(station)
        subject.touch_out(station)
        expect(subject.entry_station).to eq nil
      end
      it 'saves the exit station' do
        subject.top_up(5)
        subject.touch_in(station)
        subject.touch_out(station)
        expect(subject.exit_station).to eq station
      end
      it 'saves the journey' do
        subject.top_up(5)
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect(subject.journeys).to eq [{entry_station: entry_station, exit_station: exit_station}]
      end
    end
    context 'less than minimum fare on card' do
      it 'raises an error on touch in' do
        min_fare = Oystercard::MINIMUM_FARE
        expect { subject.touch_in(station) }.to raise_error("Minimum fare is £#{min_fare}")
      end
    end
    context 'maximum balance exceeded' do
      it 'raises an error on to up' do
        maximum_balance = Oystercard::MAXIMUM_BALANCE
        subject.top_up(90)
        expect { subject.top_up(1) }.to raise_error("Maximum balance is £#{maximum_balance}")
      end
    end
    context 'when set up' do
      it 'has an empty list of journeys' do
        expect(subject.journeys).to be_empty
      end
    end
  end
end
