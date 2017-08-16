require 'open-uri'
require 'nokogiri'
require 'pry'

class Test
  attr_accessor :date_with_link, :date_with_track_and_sponsor


  def initialize
    @date_with_link = []
    @date_with_track_and_sponsor = []
    select_month("http://hpdejunkie.com/east/", "August")
    # month_with_track_and_sponsor
    # month_with_track
  end

  def select_month(region_url, month)
    month_with_link = []
    calendar_link = ""
    calendar_month = Nokogiri::HTML(open(region_url))
    calendar_month.xpath('//*[@id="events-date-dropdown"]/option'). each do |month|
      month_name = month.text
      link = month.attr('value')
      month_with_link << {month_name => link}
    end

    month_with_link.each do |month_hash|
      selected_month_hash = month_hash.select {|month_name, link| month_name == month}
        selected_month_hash.each_value{|link| calendar_link << link}
    end

    calendar_month = Nokogiri::HTML(open(calendar_link))
    #iterate over weeks
    calendar_month.css('table.em-calendar tbody tr').each do |week|
      #TODO:need to figure out escape sequence, if there aren't any events for that month then it needs to return a message stating that
      #iterate over days
      # binding.pry
        week.css('td.eventful a').each do |day|
          # binding.pry
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
