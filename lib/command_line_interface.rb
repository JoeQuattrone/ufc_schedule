require 'pry'
require 'nokogiri'

class UfcSchedule::CommandLineInterface

  def run
    greeting
    #list_schedule
  end

  def greeting
    puts "Hello fight fan, welcome to your UFC gem! To exit this gem at any time, enter 'exit'. To view a list of upcoming ufc events enter '1'."
    puts "
    "
  end

  def choose_to_view_schedule
    input = gets.strip

    while input != "exit"
      if input == "1"
        list_schedule

      else
        puts "Please enter a valid command."
      end
    end
  end

  def list_schedule
    puts "1. Jones vs Gustafsson - Sat, Dec 29 / 10:00 PM EST. Las Vegas, NV United States"
    puts "2. Cejudo vs Dillashaw - Sat, Jan 19 / 10:00 PM EST. Brooklyn, NY United States "


  end

  def choose_fight_card
    puts "To learn more about who's fighting on a card, enter  the number of the fight card you'd like more info on."

    input = gets.strip

    case input
    when "1"
      puts "More info on first fight" #list_fights[0]
    when "2"
      puts "More info on second fight" #list_fights[1]
    end
  end

  def list_fights

  end

  def choose_fight

  end

  def list_fighter_stats

  end

end
