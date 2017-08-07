require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  attr_accessor :date_with_link, :date_with_track_and_sponsor



  def initialize
    # @date_with_link = [{"3"=>"http://hpdejunkie.com/events/2017-08-03/?category=48"}, {"6"=>"http://hpdejunkie.com/events/2017-08-06/?category=48"}, {"7"=>"http://hpdejunkie.com/events/2017-08-07/?category=48"}]

    @date_with_track_and_sponsor = [{"3"=> [{:sponsor=>"Apex Driving Events", :track=>"Lime Rock Park, Lakeville CT"}]}, {"6"=> [{:sponsor=>"Hooked on Driving", :track=>"VIR, Alton VA"}, {:sponsor=>"Rezoom Motorsports", :track=>"Barber Motorsports Park, Leeds AL"}]}]

#########################################################################
  self.date_with_track_and_sponsor.each do |date_sponsor_track_hash|
    date_sponsor_track_hash.each do |date, sponsor_track_arr|
      sponsor_track_arr.each {|key, value| puts value}

    end
  end

  end

  def month_with_track

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

  def scrape_month#(region_url)
    #TODO:replace hard code address with argument
    #date_with_link = []
    calendar_month = Nokogiri::HTML(open("http://hpdejunkie.com/east/"))
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
