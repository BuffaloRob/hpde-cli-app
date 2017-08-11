class Hpde::Sponsor
  attr_accessor :name, :tracks, :days, :event

  # Sponsor.name = "Hooked on Driving"
  # Sponsor.url = "https://www.hookedondriving.com/category.cfm?category=1&region=0"
  # Sponsor.tracks = ["New Jersey Motorsports Park", "Road Atlanta"]
  # Sponsor.dates = ["12","13","19","20"]
  @@all = []
  def initialize(name = nil)
    @name = name

  end

  def tracks

  end

  def days

  end

end
