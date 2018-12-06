require_relative 'oystercard'
require_relative 'entry_station'
require_relative 'exit_station'

class Journey

  MINIMUM_FARE = 1


  def initialize
    @journey = []
  end

  def in_transit?
    @in_transit == nil ? false : true
  end

  def get_entry_station(entry_station, zone)
    station = Station.new(entry_station, zone)
    @entry_station = station.info
    @journey << @entry_station
  end

  def get_exit_station(exit_station, zone)
    station = Station.new(exit_station, zone)
    @exit_station = station.info
    @journey << @exit_station
  end

  def fare
    MINIMUM_FARE
  end

  def save
    @journey
  end

end
