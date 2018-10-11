require 'journey'

describe Journey do
  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station) }

  it 'has a start' do
    journey = Journey.new(entry_station)
    expect(journey.start).to eq entry_station
  end

  it 'has an end' do
    journey = Journey.new(entry_station)
    journey.finish(exit_station)
    expect(journey.end).to eq exit_station
  end

describe '#finish' do
  it 'ends the journey' do
    journey = Journey.new(entry_station)
    journey.finish(exit_station)
    expect(journey.complete?).to eq true
  end
end

describe '#fare' do
  context 'after a valid journey' do
    it 'charges the min fare' do
      journey = Journey.new(entry_station)
      journey.finish(exit_station)
      expect(journey.fare).to eq 1
    end
  end
  context 'after an invalid journey' do
    it 'charges the penalty fare' do
      journey = Journey.new(nil)
      journey.finish(exit_station)
      expect(journey.fare).to eq 6
    end
  end
end

end
