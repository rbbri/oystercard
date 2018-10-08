# frozen_string_literal: true

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  attr_reader :balance, :entry_station, :exit_station, :journeys

  def initialize
    @balance = 0
    @journeys = []
    @entry_station = nil
    @exit_station = nil
  end

  def top_up(amount)
    raise "Maximum balance is £#{MAXIMUM_BALANCE}" if max?
    @balance += amount
  end

  def in_journey?
    entry_station != nil
  end

  def touch_in(station)
    raise "Minimum fare is £#{MINIMUM_FARE}" if min?
    set_entry(station)
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    set_exit(station)
    save_journey
  end

  private

  def max?
    @balance >= MAXIMUM_BALANCE
  end

  def min?
    @balance <= MINIMUM_FARE
  end

  def deduct(amount)
    @balance -= amount
  end

  def save_journey
    @journeys << {entry_station: @entry_station, exit_station: @exit_station}
    @entry_station = nil
  end

  def set_entry(station)
    @entry_station = station
  end

  def set_exit(station)
    @exit_station = station
  end

end
