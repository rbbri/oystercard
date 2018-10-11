# frozen_string_literal: true

require 'oystercard'
describe Oystercard do
  let(:station) { double(:station) }
  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station) }

  describe '#Top_up' do
    it 'adds money to the card' do
      subject.top_up(5)
      expect(subject.balance).to eq 5
    end
  end

  describe '#Touch_in' do
    it 'starts a journey' do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject.current_journey).to_not eq nil
    end
    it 'remembers the entry station' do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end
  end

  describe '#Touch_out' do
   context 'after a valid journey' do
     it 'deducts the min fare from balance' do
       min_fare = Oystercard::MINIMUM_FARE
       subject.top_up(5)
       subject.touch_in(entry_station)
       expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(- min_fare)
     end
   end
    context 'after an invalid journey' do
      it 'deducts the penalty fare from balance' do
        min_fare = Oystercard::PENALTY_FARE
        subject.top_up(5)
        expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(- min_fare)
      end
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
      expect(subject.journeys).to eq [{ entry_station: entry_station, exit_station: exit_station }]
    end
  end

  context 'Less than minimum fare on card' do
    it 'raises an error on touch in' do
      min_fare = Oystercard::MINIMUM_FARE
      expect { subject.touch_in(station) }.to raise_error("Minimum fare is £#{min_fare}")
    end
  end
  context 'Maximum balance exceeded' do
    it 'raises an error on top up' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(90)
      expect { subject.top_up(1) }.to raise_error("Maximum balance is £#{maximum_balance}")
    end
  end
  context 'When set up' do
    it 'has an empty list of journeys' do
      expect(subject.journeys).to be_empty
    end

    it 'has an initial balance 0' do
      expect(subject.balance).to eq 0
    end
    it 'is initially not in a journey' do
      expect(subject.current_journey).to eq nil
    end
  end
end
