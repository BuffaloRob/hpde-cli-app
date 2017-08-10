#relates the sponsor, track and day together

  attr_accessor :track, :sponsor, :day
  def initialize(track_1, sponsor, day)
    @track = track_1
    @sponsor = sponsor
    @day = day
    @track.event = self
    track_1.sponsor = sponsor
    sponsor.track = track_1
    day.track = track_1
  end
