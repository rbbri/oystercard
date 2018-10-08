require 'oystercard'
describe Oystercard do
describe '#balance' do
  it 'has an initial balance 0' do
    oystercard = Oystercard.new
    expect(oystercard.balance).to eq 0
  end
end
describe '#top_up' do
  it 'adds money to the card' do
    oystercard = Oystercard.new
    oystercard.top_up(5)
    expect(oystercard.balance).to eq 5
  end

describe '#deduct' do
  it 'subtracts money from the card' do
    oystercard = Oystercard.new
    oystercard.top_up(10)
    oystercard.deduct(5)
    expect(oystercard.balance).to eq 5        
  end
end

context 'maximum balance exceeded' do
  it 'raises an error' do
    oystercard = Oystercard.new
    maximum_balance = Oystercard::MAXIMUM_BALANCE
    oystercard.top_up(90)
    expect {oystercard.top_up(1)}.to raise_error("Maximum balance is £#{maximum_balance}")
  end

end
end
end
