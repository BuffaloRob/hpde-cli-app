require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  attr_accessor :schedule, :days_events



  def initialize
    @schedule = [{"3"=>"http://hpdejunkie.com/events/2017-08-03/?category=48"}, {"6"=>"http://hpdejunkie.com/events/2017-08-06/?category=48"}, {"7"=>"http://hpdejunkie.com/events/2017-08-07/?category=48"}]
    @days_events = []
    # = [[{"Apex Driving Events"=>"Lime Rock Park, Lakeville CT"}], [{"Hooked on Driving"=>"VIR, Alton VA"}, {"Rezoom Motorsports"=>"Barber Motorsports Park, Leeds AL"}]]
#########################################################################
    #iterate over each hash in the array @schedule
    self.schedule.each do |day|
      #in each hash run scrape_day(day_url) passing in the link(value) of each hash as the arg
      #pushes sponsor=>track to days_events array as an array of hashes for each day
      day.each_value{|link| self.days_events << scrape_day(link)}

      dagy.each_pair
    end
    self.days_events.each do |event|
      event.each_value
  end


 # use merge, run scraped_day in the block to replace the old value with the new scraped_day return value
  def month_with_tracks
    self.schedule.each do |day|
      #in each hash run scrape_day(day_url) passing in the link(value) of each hash as the arg
      day.each_value{|link| self.days_events << scrape_day(link)}
    end
  end

  def scrape_day(day_url)
    day = Nokogiri::HTML(open(day_url))
    events = []
    #iterate over seperate track events
    day.css('table.events-table tbody tr td table tr').each do |event|
      sponsors = event.css('a').text
      tracks = event.css('i').text
      events << {sponsors => tracks}
    end
    events.uniq
  end

  def scrape_month#(region_url)
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
        self.schedule << {day_number => link}
      end
    end
  end

  scraper = Scraper.new

end

#   def scrape_region
# #Hard code this instead. Regions won't change. have cli list regions and use if/else statement to link to chosen region, then start scraping.
#     regions = []
#     home_page = Nokogiri::HTML(open("http://hpdejunkie.com/"))
#     home_page.css('div.columns.three').each do |choose_region|
#       choose_region.css('.button.btn-red').each do |map|
#         regions << map.css('.map-text').text
#       end
#     end
#     # puts "Choose your region"
#     # puts "#{regions.each_with_index}"
#     # region_choice = gets.strip
#   end
