class Concerns::CommandLineInterface
extend Concerns::SharedCLIMethods

  def run
    greeting
    choose_to_view_schedule
    goodbye
  end

  def greeting
    puts "Hello fight fan, welcome to your UFC gem! To exit this gem at any time, enter 'exit'. To view a list of upcoming ufc events enter '1'."
    puts ""
    Concerns::API.get_categories
  end

  def choose_to_view_schedule
    input = nil

    while input != "exit"
      input = gets.strip
      if input == "1"
        list_schedule
        #breaks the loop so person only has to type 'exit' once to leave the program
        break
      elsif input != "exit" && input != "1"
        invalid_command_response
      end
    end
  end

  def list_schedule
    Concerns::Events.list_events
    #output should look like this below:
    # puts "1. Jones vs Gustafsson - Sat, Dec 29 / 10:00 PM EST. Las Vegas, NV United States"
    # puts "2. Cejudo vs Dillashaw - Sat, Jan 19 / 10:00 PM EST. Brooklyn, NY United States "

    choose_fight_card
  end

  def choose_fight_card
    Concerns::API.scrape_fights(Concerns::Events.all)
    puts ""
    puts "To learn more about who's fighting, enter the number of the fight card you'd like more info on."

    input = nil

    while input != "exit"
    input = gets.strip

      case input
      when "1"
        list_fights(input.to_i)
      when "2"
        puts "More info on second fight"
      when "exit"
        break
      else
        invalid_command_response
      end
    end
  end

  def list_fights(input)
    puts "1. Jon Jones vs Alexander Gustafson - Light Heavyweight Title Bout"
    puts "Cris Cyborg vs Amanda Nunes - Women's Featherweight Title Bout"
    #binding.pry

    Concerns::Events.all[input - 1].event_fights.each_with_index do |fight, index|

      puts "#{index +1 }. #{fight.red_name} vs. #{fight.blue_name} - #{fight.red_weight}"
    end
    choose_fight
  end

  def choose_fight
    puts ""
    puts "To see stats of the fighters, enter the number of their corresponding fight"

    input = gets.strip

  end

  def list_fighter_stats

  end

  def goodbye
    puts "Goodbye"
  end

  def invalid_command_response
    puts "Please enter a valid command."
  end

end
