class Oystercard
  MAXIMUM_BALANCE = 90
  attr_reader :balance
  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    raise "Maximum balance is £#{MAXIMUM_BALANCE}" if max?
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_use
  end

  def touch_in
    @in_use = true
  end

  def touch_out
    @in_use = false
  end


  private

  def max?
    @balance >= MAXIMUM_BALANCE
  end



end
