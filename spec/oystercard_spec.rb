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
end
end
