require 'open-uri'
require 'nokogiri'
require 'pry'

class Hpde::Scraper
  attr_accessor :date_with_link, :date_with_track_and_sponsor


  def initialize(region_url)
    @date_with_link = []
    @date_with_track_and_sponsor = []
    scrape_month(region_url)
    month_with_track_and_sponsor
    month_with_track
  end

  def day_input_valid?(chosen_day)
    self.date_with_track_and_sponsor.each do |date_sponsor_track_hash|
      date_sponsor_track_hash.each do |date, sponsor_track_array|
        date == chosen_day
      end
    end
  end

  #TODO:Change to use reference to objects, not scraped info. This can be done to all methods that get called after month_with_track
  def day_detailed_info(chosen_day)
    self.date_with_track_and_sponsor.each do |date_sponsor_track_hash|
      if date_sponsor_track_hash.key?(chosen_day)
        date_sponsor_track_hash.each do |date, sponsor_track_array|
          sponsor_track_array.each do |key|
            puts  "Event sponsored by #{key[:sponsor]} at #{key[:track]}"
            puts ""
          end
        end
      end
    end
  end

  def select_month(region_url)
    calendar_month = Nokogiri::HTML(open(region_url))

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
          new_event = Hpde::Event.new(track, sponsor, day)
          binding.pry
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
    #TODO: currently doesn't scrape any event occurring today"
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
