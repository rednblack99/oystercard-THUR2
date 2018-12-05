require_relative 'station.rb'

class Oystercard

  attr_reader :balance
  attr_accessor :card, :journeys
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    # (entry_station = Station.new, exit_station = Station.new)
    @balance = 0
    @card = false
    @entry_station = nil
    @exit_station = nil
    @journeys = []
  end

  def top_up(amount)
    fail "Balance has exceeded maximum balance of £#{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance = @balance + amount
  end

  def in_journey?
    @entry_station == nil ? false : true
  end

  def touch_in(entry_station)
    # fail 'Card already touched in' if @card.in_journey?
    fail "Your balance is too low" if (@balance - MINIMUM_FARE) < 0
    @card = true
    @entry_station = entry_station
    journey
  end

  def touch_out(exit_station)
    # fail 'Card already touched out' if !(@card.in_journey?)
    @card == true ? deduct(MINIMUM_FARE) : @card
    @card = false
    @exit_station = exit_station
    journey
    @journeys << journey
  end

  def journey
    journey = { entry_station: @entry_station, exit_station: @exit_station }
  end

  private
  def deduct(amount)
    @balance -= amount
  end
end
