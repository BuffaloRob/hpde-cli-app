require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  attr_accessor :date_with_link, :date_with_track_and_sponsor

#TODO: 1) set-up proper test environment

  def initialize(region_url)
    @date_with_link = []
    @date_with_track_and_sponsor = []
    scrape_month(region_url)
    month_with_track
  end

  def month_with_track
    #iterate over each 'date' hash in date_with_track_and_sponsor
    self.date_with_track_and_sponsor.each do |date_sponsor_track_hash|
      #iterate over each array of hash(es) acting as the key in date_with_track_and_sponsor
      date_sponsor_track_hash.each do |date, sponsor_track_array|
        #iterate over each :track key
        sponsor_track_array.each do |key|
          puts "#{date} - #{key[:track]}"
        end
      end
    end
  end


  def month_with_track_and_sponsor
    #iterate over each hash in the array @date_with_link
    self.date_with_link.each do |day_hash|
      #changes the value(link) of the date_with_link hashes to a hash of sponsors and tracks by running scrape_day on the link.
      @date_with_track_and_sponsor << day_hash.each {|date, link| day_hash[date] = scrape_day(link)}
    end
  end

  def scrape_day(day_url)
    day = Nokogiri::HTML(open(day_url))
    events = []
    #iterate over seperate track events
    day.css('table.events-table tbody tr td table tr').each do |event|
      sponsors = event.css('a').text
      tracks = event.css('i').text
      events << {sponsor: sponsors, track: tracks}
    end
    events.uniq
  end

  def scrape_month(region_url)
    #TODO:replace hard code address with argument
    #date_with_link = []
    calendar_month = Nokogiri::HTML(open(region_url))
    #iterate over weeks
    calendar_month.css('table.em-calendar tbody tr').each do |week|
      #iterate over days
      week.css('td.eventful a').each do |day|
        #sets day_number = date of event
        day_number = day.text
        #sets link for that date
        link = day.attr('href')
        self.date_with_link << {day_number => link}
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
