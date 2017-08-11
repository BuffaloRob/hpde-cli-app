class Hpde::Event #relates the sponsor, track and day together

  attr_accessor :track, :sponsor, :day

  @@all = []

  def initialize(track = nil, sponsor = nil, day = nil)
    @track = track
    @sponsor = sponsor
    @day = day
    @track.event = self
    @track.sponsor = sponsor
    @track.day = day
    @day.event = self
    @day.sponsor = sponsor
    @day.track = track
    @sponsor.event = self
    @sponsor.day = day
    @sponsor.track = track
    @@all << self
  end

  def self.all
    @@all
  end

  def self.reset
    @@all.clear
  end

  ### Do I even need this?
  def self.find(input)
    self.all[input-1] #try [input.to_i-1] if it doesn't work initially
  end

end
