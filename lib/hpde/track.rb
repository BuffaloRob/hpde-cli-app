class Hpde::Track
  attr_accessor :name, :sponsors, :days, :location, :event

  # Track.name = "Road Atlanta"
  # Track.sponsors = ["Hooked on Driving", "NASA HPDE"]
  # Track.dates = ["19", "20", "27"]

  @@all = []
  def initialize(name = nil, location = nil)
    @name = name
    @location = location

  end

end
