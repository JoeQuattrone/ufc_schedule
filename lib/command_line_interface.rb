class Concerns::CommandLineInterface
extend Concerns::SharedCLIMethods

  def run
    greeting
    choose_to_view_schedule
    goodbye
  end

  def greeting
    #greets the user and makes a call to the UFC API to request schedule data
    puts "Hello fight fan, welcome to your UFC gem! To view a list of upcoming UFC events enter '1'. To exit this gem at any time, enter 'exit'. To go back to the previous menu, enter 'back'."
    puts ""
    Concerns::API.get_categories
  end

  def choose_to_view_schedule
    #Takes user input and returns schedule if input == "1"
    input = nil

    input = gets.strip
    if input == "1"
      system "clear"
      list_schedule
    elsif input == "exit"
      goodbye
      exit
    else
      invalid_command_response
      choose_to_view_schedule
    end
  end

  def list_schedule
    #List current UFC events from API data and prompts user to learn more info on the events
    Concerns::Events.list_events
    puts ""
    puts "To learn more about who's fighting, enter the number of the fight card you'd like more info on."
    puts ""
    choose_fight_card
  end

  def choose_fight_card
    #Scrapes all the fights from all of the events listed on the schedule and creates fight objects related to each event. Allows user to choose an event, if valid, it will list fights for that event
    Concerns::API.scrape_fights(Concerns::Events.all)
    input = gets.strip

      if input.to_i.between?(1, Concerns::Events.all.size)
        system "clear"
        list_fights(input.to_i)
      elsif input == "back"
        list_schedule
      elsif input == "exit"
        goodbye
        exit
      else
        invalid_command_response
        choose_fight_card
      end
  end

  def list_fights(input)
    #finds an event and lists the fights on that event and calls the choose_fight function
    find_event = Concerns::Events.all[input - 1]

    find_event.event_fights.each_with_index do |fight, index|
      puts "#{index + 1}. #{fight.red_name} vs. #{fight.blue_name} - #{fight.red_weight}"
    end
    choose_fight(find_event)
  end

  def choose_fight(event)
    #Allows user to choose a specific fight and pulls stats on fighters in that fight
    puts ""
    puts "To see stats of the fighters, enter the number of their corresponding fight, or enter 'back' to go back to the schedule"

    input = gets.strip
    #14.between?(10,20) # true

    if input.to_i.between?(1, event.event_fights.count)
      specific_fight = event.event_fights[input.to_i - 1]
      puts "Name:   #{specific_fight.red_name}  #{specific_fight.blue_name}"
      puts "Record: #{specific_fight.red_record}  #{specific_fight.blue_record}"
      puts "Height: #{specific_fight.red_height}    #{specific_fight.blue_height}"
      puts "Weight: #{specific_fight.red_weight}  #{specific_fight.blue_weight}"

      choose_fight(event)
    elsif input == "exit"
      goodbye
      exit
    elsif input == "back"
      list_schedule
    else
      invalid_command_response
      choose_fight(event)
    end
  end

  def goodbye
    puts "Goodbye"
  end

  def invalid_command_response
    puts "Please enter a valid command."
  end

end
