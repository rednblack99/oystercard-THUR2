class Station

  attr_reader :name, :zone

  def initialize(name= 'Old Street', zone= 1)
    @name = name
    @zone = zone
  end

end
