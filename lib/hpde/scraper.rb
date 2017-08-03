require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def initialize
    schedule = []
    #replace address with argument
    calendar = Nokogiri::HTML(open("http://hpdejunkie.com/east/"))
    #iterate over weeks
    calendar.css('table.em-calendar tbody tr').each do |week|
      #iterate over days
      week.css('td.eventful a').each do |day|
        #adds date integer to dates array
        day_number = day.text
        link = day.attr('href')
        schedule << {day_number => link}
      end
    end
    binding.pry
  end

  def scrape_day

  end

  def scrape_month(region)
    schedule = []
    #replace address with argument
    calendar = Nokogiri::HTML(open("http://hpdejunkie.com/east/"))
    #iterate over weeks
    calendar.css('table.em-calendar tbody tr').each do |week|
      #iterate over days
      week.css('td.eventful a').each do |day|
        #adds date integer to dates array
        day_number = day.text
        link = day.attr('href')
        schedule << {day_number => link}
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
