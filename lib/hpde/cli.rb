
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
    puts ""
    input = gets.strip
    puts ""
    puts "Please be patient, it may take a little while to grab all the information"
    puts "***************************************************************************"
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
      puts ""
      puts "That's not one of the choices, try again"
      puts ""
      select_region
    end
    puts "***************************************************************************"
  end

  # def select_month
  #   puts "Select the month number you would like to see:"
  #   #add way to link to various months
  # end

  def select_day
    puts ""
    puts ""
    puts "Type in the number of the day you would like to view in more detail or type in the name of the track to view all events at that venue:"
    puts ""
    input = gets.strip
    puts ""
    Hpde::Scraper.pull_day_info(input)
  end

  def view_month_with_track
    #call Scraper.scrape_month passing in region_url
    #call month_with_track to return values you want to see
  end

end
