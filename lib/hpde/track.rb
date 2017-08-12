class Hpde::Track
  attr_accessor :name, :sponsor, :day, :location, :event
  attr_reader :sponsors, :days

  @@all = []
  def initialize(name = nil, location = nil)
    #TODO: add location
    @name = name
  end

end
