class Hpde::Day
  attr_accessor :name, :sponsor, :track, :event

  def initialize(name)
    @name = name
  end

  def self.find(chosen_day)
    self.all[day.name == chosen_day]
  end

end
