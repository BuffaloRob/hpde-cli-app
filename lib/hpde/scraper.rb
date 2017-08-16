require 'open-uri'
require 'nokogiri'
require 'pry'

class Hpde::Scraper
  attr_accessor :date_with_link, :date_with_track_and_sponsor, :empty_month

  def initialize(region_url, month)
    @date_with_link = []
    @date_with_track_and_sponsor = []
    selected_month = select_month(region_url, month)
    if selected_month == false
      @empty_month = true
    end
    month_with_track_and_sponsor
    month_with_track
  end

  def self.day_input_valid?(chosen_day)
    Hpde::Event.select_day(chosen_day)
    check_day = Hpde::Event.select_day_name.first
    check_day == chosen_day
  end

  def self.day_detailed_info
    # Hpde::Event.select_day(chosen_day) is already being called on day_input_valid? in the cli class, If you call again here it causes a double print
    Hpde::Event.list_detailed_day
  end

  def month_with_track
    #iterate over each 'date' hash in date_with_track_and_sponsor
    self.date_with_track_and_sponsor.each do |date_sponsor_track_hash|
      #iterate over each array of hash(es) acting as the key in date_with_track_and_sponsor
      date_sponsor_track_hash.each do |date, sponsor_track_array|
        #iterate over each :track & :sponsor key. Make new objects
        sponsor_track_array.each do |key|
          puts "#{date} - #{key[:track]}"
          track = Hpde::Track.new(key[:track])
          sponsor = Hpde::Sponsor.new(key[:sponsor])
          day = Hpde::Day.new(date)
          event = Hpde::Event.new(track, sponsor, day)
        end
      end
    end
  end

  def month_with_track_and_sponsor
    #iterate over each hash in the array @date_with_link
    self.date_with_link.each do |day_hash|
      #changes the value(s) of the date_with_link hashes to a hash of sponsors and tracks by running scrape_day on the link.
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
    counter = 0
    #iterate over weeks
    calendar_month.css('table.em-calendar tbody tr').each do |week|
      #iterate over days
      week.css('td.eventful a').each do |day|
        counter += 1
        #sets day_number = date of event
        day_number = day.text
        #sets link for that date
        link = day.attr('href')
        self.date_with_link << {day_number => link}
      end
    end
    #if counter never runs we know nothing is scheduled
    if counter < 1
      puts ""
      puts "Nothing is scheduled for this month"
      false
    end
  end

end
