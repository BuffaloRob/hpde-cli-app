class Hpde::Sponsor
  attr_accessor :name, :track, :day, :event
  attr_reader :tracks, :days

  # Sponsor.name = "Hooked on Driving"
  # Sponsor.url = "https://www.hookedondriving.com/category.cfm?category=1&region=0"


  def initialize(name)
    @name = name
    # @tracks = []
    # @sponsors =[]
    # day.sponsor = self
    # track.sponsor = self
    # @tracks << track
    # @days << day


  end

end
