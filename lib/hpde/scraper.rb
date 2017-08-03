require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def initialize

  end

  def scrape_calendar(region)
    dates = []
    #replace address with argument
    calendar = Nokogiri::HTML(open("http://hpdejunkie.com/east/"))
    #iterate over weeks
    calendar.css('table.em-calendar tbody tr').each do |row|
      #iterate over days
      row.css('td.eventful a').each do |day|
        dates << day.text
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
