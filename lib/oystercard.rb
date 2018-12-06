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

  def touch_in(entry_station, zone)
    fail "Your balance is too low" if (@balance - MINIMUM_FARE) < 0
    fail "You've already touched in" if @card == true
    @card = true
    @entry_station = {entry_station: entry_station, zone: zone}
    journey
  end

  def touch_out(exit_station, zone)
    fail "You're not touched in" if @card == false
    @card == true ? deduct(MINIMUM_FARE) : @card
    @card = false
    @exit_station = {exit_station: exit_station, zone: zone}
    journey
    @journeys << journey
  end

  def journey
    journey = [@entry_station, @exit_station ]
  end

  private
  def deduct(amount)
    @balance -= amount
  end
end
