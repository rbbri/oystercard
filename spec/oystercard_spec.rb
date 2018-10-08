require 'oystercard'
describe Oystercard do
describe '#balance' do
  it 'has an initial balance 0' do
    oystercard = Oystercard.new
    expect(oystercard.balance).to eq 0
  end
end

end
