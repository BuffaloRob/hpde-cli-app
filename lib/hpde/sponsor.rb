class Hpde::Sponsor
  attr_accessor :name, :track, :day, :event

  # Sponsor.url = "https://www.hookedondriving.com/category.cfm?category=1&region=0"

  def initialize(name)
    @name = name
  end

end
