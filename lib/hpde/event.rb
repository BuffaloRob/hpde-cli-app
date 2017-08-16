 class Hpde::Event #relates the sponsor, track and day together

  attr_accessor :track, :sponsor, :day

  @@all = []
  @@day = []

  def initialize(track = nil, sponsor = nil, day = nil)
    @track = track
    @sponsor = sponsor
    @day = day
    @track.event = self
    @day.event = self
    @sponsor.event = self
    @@all << self
  end

  def self.all
    @@all
  end

  def self.day
    @@day
  end

  def self.all_reset
    @@all.clear
  end

  def self.day_reset
    @@day.clear
  end

  def self.select_day(day)
    self.all.map do |date|
      if date.day.name == day
        @@day << date
      end
    end
  end

  def self.list_detailed_day
    self.day.each do |attr|
      day = attr.day.name
      track = attr.track.name
      sponsor = attr.sponsor.name
      puts "Day of the Month: #{day}"
      puts "#{sponsor} will be sponsoring a High Performance Driving Event at #{track}"
      puts ""
    end

  end

  def self.select_day_name
    self.day.collect do |attr|
      attr.day.name
    end
  end

  # def self.select_sponsor_name
  #   self.day.each do |attr|
  #     attr.sponsor.name
  #   end
  # end
  #
  # def self.select_track_name
  #   self.day.each do |attr|
  #     attr.track.name
  #   end
  # end

end
