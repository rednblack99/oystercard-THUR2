class EntryStation

  attr_reader :name, :zone

  def initialize(name= 'Old Street', zone= 1)
    @name = name
    @zone = zone
  end

  def info
    {entry_station: @name, zone: @zone}
  end

end
