require_relative 'station.rb'
require_relative 'journey'


class Oystercard

  attr_reader :balance, :journey
  attr_accessor :in_transit, :journey_history
  MAXIMUM_BALANCE = 90

  def initialize
    @balance = 0
    @in_transit = false
    @journey_history = []
  end

  def top_up(amount)
    fail "Balance has exceeded maximum balance of £#{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance = @balance + amount
  end

  def touch_in
    fail "Your balance is too low" if (@balance - Journey::MINIMUM_FARE) < 0
    fail "You've already touched in" if @in_transit
    @journey = Journey.new
    @in_transit = true
    @journey.get_entry_station
  end

  def touch_out
    fail "You're not touched in" if !@in_transit
    @in_transit = false
    @journey.get_exit_station
    @balance -= @journey.fare
    @journey_history << @journey.save
  end

end
