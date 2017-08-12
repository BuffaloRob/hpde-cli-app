class Hpde::Day
  attr_accessor :name, :sponsor, :track, :event
  attr_reader :sponsors, :tracks

  # Day.name = "18"
  # Day.sponsors = ["Hooked on Driving", "NASA HPDE"]
  # Day.tracks = ["Road Atlanta", "VIR"]
  @@all = []
  def initialize(name)
    @name = name
    # @tracks = []
    # @sponsors =[]
    # sponsor.day = self
    # track.day = self
    # @tracks << track
    # @sponsors << sponsor
  end

  def self.find(chosen_day)
    self.all[day.name == chosen_day]
  end

  # def add_track(track)
  #   @tracks << track
  #   track.day = self
  # end
end
