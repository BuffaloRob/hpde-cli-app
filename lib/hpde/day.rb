class Hpde::Day
  attr_accessor :name, :sponsors, :tracks, :event

  # Day.name = "18"
  # Day.sponsors = ["Hooked on Driving", "NASA HPDE"]
  # Day.tracks = ["Road Atlanta", "VIR"]
  @@all = []
  def initialize(name)
    @name = name

  end

end