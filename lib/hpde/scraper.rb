require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def initialize
    events = []
    #TODO:replace hard code address with argument
    day = Nokogiri::HTML(open("http://hpdejunkie.com/events/2017-08-05/?category=48/"))
    binding.pry
    day.css('table.events-table tbody').each do |event|
      #iterate over seperate track events
      #How do you seperate this from the 'td' that has the dates?
      sponsor = event.css('tr td table tbody tr td a').text
      track = event.css('tr td table tbody tr td i').text
      binding.pry
    end
  end

  def scrape_day(day_url)
    events = []
    #TODO:replace hard code address with argument
    day = Nokogiri::HTML(open("http://hpdejunkie.com/events/2017-08-05/?category=48/"))
    day.css('table.events-table tbody').each do |event|
      #iterate over seperate track events
      #How do you seperate this from the 'td' that has the dates?
      sponsor = event.css('tr td table tbody tr td a').text
      track = event.css('tr td table tbody tr td i').text
      binding.pry
    end
  end

  def scrape_month(region_url)
    schedule = []
    #TODO:replace hard code address with argument
    calendar_month = Nokogiri::HTML(open("http://hpdejunkie.com/east/"))
    #iterate over weeks
    calendar_month.css('table.em-calendar tbody tr').each do |week|
      #iterate over days
      week.css('td.eventful a').each do |day|
        #sets day_number = date of event
        day_number = day.text
        #sets link for that date
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
