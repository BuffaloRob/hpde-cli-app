class Hpde::CLI

  def call
    select_region
  end

  def select_region
    puts "Type the number of the region you would like to view:"
    puts <<~HEREDOC
      1. Pacific
      2. Mountain
      3. Central
      4. East
      HEREDOC
    #add if/else to select link to specified region
  end

  def select_month
    puts "Select the month number you would like to see:"
    #add way to link to various months
  end

  def view_month_with_track
    #call Scraper.scrape_month passing in region_url
    #call month_with_track to return values you want to see
  end

end
