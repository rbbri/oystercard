class Oystercard
  MAXIMUM_BALANCE = 90
  attr_reader :balance
  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Maximum balance is £#{MAXIMUM_BALANCE}" if max?
    @balance += amount
  end
  private
  def max?
    @balance >= MAXIMUM_BALANCE
  end
end
