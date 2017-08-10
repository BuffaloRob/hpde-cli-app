class Hpde::Event #relates the sponsor, track and day together

  attr_accessor :track, :sponsor, :day

  @@all = []
  def initialize(track, sponsor, day)
    @track = track
    @sponsor = sponsor
    @day = day
    @track.event = self
  end

end
