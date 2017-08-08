
class Hpde::CLI

  def call
    select_region
    select_day
  end

  def select_region
    puts "Type the number of the region you would like to view:"
    puts <<~HEREDOC
      1. Pacific
      2. Mountain
      3. Central
      4. East
    HEREDOC

    input = gets.strip
    case input
    when "1"
      Hpde::Scraper.new("http://hpdejunkie.com/pacific/")
    when "2"
      Hpde::Scraper.new("http://hpdejunkie.com/mountain/")
    when "3"
      Hpde::Scraper.new("http://hpdejunkie.com/central/")
    when "4"
      Hpde::Scraper.new("http://hpdejunkie.com/east/")
    else
      puts "That's not one of the choices"
    end
  end

  # def select_month
  #   puts "Select the month number you would like to see:"
  #   #add way to link to various months
  # end

  def select_day
    puts "Type in the number of the day you would like to view in more detail or type in the name of the track to view all events at that venue:"
    input = gets.strip

  end

  def view_month_with_track
    #call Scraper.scrape_month passing in region_url
    #call month_with_track to return values you want to see
  end

end
