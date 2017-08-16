class Hpde::Track
  attr_accessor :name, :sponsor, :day, :location, :event

  def initialize(name = nil, location = nil)
    @name = name
  end

end
