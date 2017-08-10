class Hpde::Track
  attr_accessor :name, :sponsors, :dates, :location

  # Track.name = "Road Atlanta"
  # Track.sponsors = ["Hooked on Driving", "NASA HPDE"]
  # Track.dates = ["19", "20", "27"]
  def initialize(name = nil, location = nil)
    @name = name
    @location = location

  end

end
