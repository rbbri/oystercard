require 'oystercard'
describe Oystercard do
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

describe '#deduct' do
  it 'subtracts money from the card' do
    subject.top_up(10)
    subject.deduct(5)
    expect(subject.balance).to eq 5
  end
end

describe '#in_journey?' do
 it 'is initially not in a journey' do
   expect(subject.in_journey?).to eq false
 end

end

describe '#touch_in' do
  it 'starts a journey' do
    subject.touch_in
    expect(subject.in_journey?).to eq true
  end
end

describe '#touch_out' do
  it 'ends the journey' do
    subject.touch_out
    expect(subject.in_journey?).to eq false
  end
end

context 'maximum balance exceeded' do
  it 'raises an error' do
    maximum_balance = Oystercard::MAXIMUM_BALANCE
    subject.top_up(90)
    expect {subject.top_up(1)}.to raise_error("Maximum balance is £#{maximum_balance}")
  end
end



end
end
