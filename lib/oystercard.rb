require_relative 'station.rb'

class Oystercard

  attr_reader :balance
  attr_accessor :card
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize(station = Station.new)
    @balance = 0
    @card = false
    @station = nil
  end

  def top_up(amount)
    fail "Balance has exceeded maximum balance of £#{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance = @balance + amount
  end

  def in_journey?
    if @station == nil
      @card = false
    else
      @card = true
    end
    @card
  end

  def touch_in(station)
    # fail 'Card already touched in' if @card.in_journey?
    fail "Your balance is too low" if (@balance - MINIMUM_FARE) < 0
    @card = true
    @station = station
  end

  def touch_out
    # fail 'Card already touched out' if !(@card.in_journey?)
    @card == true ? deduct(MINIMUM_FARE) : @card
    @station = nil
    @card = false
    end

  private
  def deduct(amount)
    @balance = @balance - amount
  end
end
