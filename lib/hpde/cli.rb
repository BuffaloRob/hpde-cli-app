
class Hpde::CLI
  attr_accessor :chosen_region

  def call
    select_region
    puts "***************************************************************************"
    select_day
    puts "***************************************************************************"
  end

  def select_region
    puts "Type the number of the region you would like to view:"
    puts <<~RUBY
      1. Pacific
      2. Mountain
      3. Central
      4. East
      ***************************************************************************
    RUBY

    puts ""
    input = gets.strip
    puts ""
    puts "Now enter the Month (as a number) that you would like to see:"
    month_number = gets.strip
    month = month_number_converter(month_number)
    puts ""
    puts "Please be patient, it may take a little while to grab all the information"
    puts "***************************************************************************"
    case input
    when "1"
      self.chosen_region = Hpde::Scraper.new("http://hpdejunkie.com/pacific/", month)
    when "2"
      self.chosen_region = Hpde::Scraper.new("http://hpdejunkie.com/mountain/", month)
    when "3"
      self.chosen_region = Hpde::Scraper.new("http://hpdejunkie.com/central/", month)
    when "4"
      self.chosen_region = Hpde::Scraper.new("http://hpdejunkie.com/east/", month)
    else
      puts ""
      puts "You must have hit a wrong key, give it another shot"
      puts ""
      select_region
    end


  end

  def select_day

    if self.chosen_region.empty_month != true
      puts ""
      puts ""
      puts "Type in the number of the day you would like to view in more detail:"
      puts ""
      input = gets.strip
      puts ""
      puts ""
      if Hpde::Scraper.day_input_valid?(input)
        Hpde::Scraper.day_detailed_info
      else
        puts "That date is invalid"
        select_day
      end
    end
  end

  def month_number_converter(month_number)
    case month_number
    when "1"
      "January"
    when "2"
      "February"
    when "3"
      "March"
    when "4"
      "April"
    when "5"
      "May"
    when "6"
      "June"
    when "7"
      "July"
    when "8"
      "August"
    when "9"
      "September"
    when "10"
      "October"
    when "11"
      "November"
    when "12"
      "December"
    else
      #TODO: make this work
      "There's only 12 months, try again"
      # month_number_converter(month_number)
    end
  end


end
