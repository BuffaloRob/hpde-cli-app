require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  attr_accessor :schedule, :events



  def initialize
    @schedule = []
    @events = []

    calendar_month = Nokogiri::HTML(open("http://hpdejunkie.com/east/"))
    #iterate over weeks
    calendar_month.css('table.em-calendar tbody tr').each do |week|
      #iterate over days
      week.css('td.eventful a').each do |day|
        #sets day_number = date of event
        day_number = day.text
        #sets link for that date
        link = day.attr('href')
        self.schedule << {day_number => link}
      end
    end
    binding.pry
  end
#to set key(the date) equal to the track(s) with HPDE's for that day (and not just the link)
#iterate over schedule, for each |day| (day = the hash for a single day)
#run Nokogiri on the link with the scrape_day method.
  # schedule.each do |day|
  #   scraped_day = scrape_day(Nokogiri::HTML(open(day_value)))
  #
  def month_with_tracks

  end

  def scrape_day(day_url)
    #events = []
    #TODO:replace hard code address with argument
    day = Nokogiri::HTML(open("http://hpdejunkie.com/events/2017-08-05/?category=48"))
    #iterate over seperate track events
    day.css('table.events-table tbody tr td table tr').each do |event|
      sponsors = event.css('a').text
      tracks = event.css('i').text
      events << {sponsors => tracks}
    end
    events.uniq
  end

  def scrape_month(region_url)
    #TODO:replace hard code address with argument
    #schedule = []
    calendar_month = Nokogiri::HTML(open("http://hpdejunkie.com/east/"))
    #iterate over weeks
    calendar_month.css('table.em-calendar tbody tr').each do |week|
      #iterate over days
      week.css('td.eventful a').each do |day|
        #sets day_number = date of event
        day_number = day.text
        #sets link for that date
        link = day.attr('href')
        @schedule << {day_number => link}
      end
    end

  end

  def scrape_region
#Hard code this instead. Regions won't change. have cli list regions and use if/else statement to link to chosen region, then start scraping.
    regions = []
    home_page = Nokogiri::HTML(open("http://hpdejunkie.com/"))
    home_page.css('div.columns.three').each do |choose_region|
      choose_region.css('.button.btn-red').each do |map|
        regions << map.css('.map-text').text
      end
    end
    # puts "Choose your region"
    # puts "#{regions.each_with_index}"
    # region_choice = gets.strip
  end

  scraper = Scraper.new

end
