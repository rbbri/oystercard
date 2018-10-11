# frozen_string_literal: true

# Describes the payment card

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  attr_reader :balance, :current_journey, :journeys, :entry_station, :exit_station

  def initialize
    @balance = 0
    @journeys = []
    @current_journey = nil
  end

  def top_up(amount)
    raise "Maximum balance is £#{MAXIMUM_BALANCE}" if max?

    @balance += amount
  end

  def touch_in(station)
    raise "Minimum fare is £#{MINIMUM_FARE}" if min?
    enter(station)
    @current_journey = Journey.new(station)
  end

  def touch_out(station)
    return deduct(PENALTY_FARE) unless !!@current_journey
    @current_journey.finish(station)
    deduct(@current_journey.fare)
    leave(station)
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
    @journeys << { entry_station: @entry_station, exit_station: @exit_station }
    @entry_station = nil
  end

  def enter(station)
    @entry_station = station
  end

  def leave(station)
    @exit_station = station
  end

  def in_journey?
    !!@current_journey
  end

end
