require_relative 'station.rb'
require_relative 'journey'


class Oystercard

  attr_reader :balance, :journey
  attr_accessor :in_transit, :journey_history
  MAXIMUM_BALANCE = 90

  def initialize(journey = Journey.new)
    @balance = 0
    @in_transit = false
    @journey = journey
    @journey_history = []
  end

  def top_up(amount)
    fail "Balance has exceeded maximum balance of £#{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance = @balance + amount
  end

  def touch_in(entry_station, zone)
    fail "Your balance is too low" if (@balance - Journey::MINIMUM_FARE) < 0
    fail "You've already touched in" if @in_transit
    @in_transit = true
    @journey.get_entry_station(entry_station, zone)
  end

  def touch_out(exit_station, zone)
    fail "You're not touched in" if !@in_transit
    @in_transit = false
    @journey.get_exit_station(exit_station, zone)
    @balance -= @journey.fare
    @journey_history << @journey.save
  end

end
