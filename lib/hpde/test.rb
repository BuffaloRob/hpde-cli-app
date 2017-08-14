require 'open-uri'
require 'nokogiri'
require 'pry'

class Test
  attr_accessor :date_with_link, :date_with_track_and_sponsor


  def initialize
    @date_with_link = []
    @date_with_track_and_sponsor = []
    select_month("http://hpdejunkie.com/pacific/")

  end

  def select_month(region_url)
    calendar_month = Nokogiri::HTML(open(region_url))
    month_select = calendar_month.css('#events-date-dropdown option:nth-child(2)').first
    binding.pry
    link = month_select.attribute('value').value
    name = month_select.text
    # binding.pry
  end

  def scrape_month(region_url)
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
end
Test.new

#events-date-dropdown > option:nth-child(10)
