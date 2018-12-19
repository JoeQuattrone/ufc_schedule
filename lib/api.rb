class Concerns::API
  def self.get_categories
    cats = RestClient.get('http://ufc-data-api.ufc.com/api/v1/us/events')
    @data = JSON.parse(cats)

    @data.each do |events|
      Concerns::Events.new_from_api(events)
    end
  end

  def self.scrape_fights(array_of_events)
    #for each event id this will scrape event data iterate through the fights and create EventFight objects for each fight on the event and associate those fights to an event
    #binding.pry
    array_of_events.each do |event|

      doc = Nokogiri::HTML(open("http://ufc-data-api.ufc.com/api/v1/us/events/#{event.id}"))


      doc.css('.flipcard-front-pre').each do |card|
        red_name = card.css('.fighter-name-red').text.strip

        blue_name = card.css('.fighter-name-blue').text.strip

        #takes valid data and makes a hash out of it
        fight_stats = card.css('.fight-card-match-up td').map {|stat| stat.text}.select {|stat| stat != stat.empty?}

        fight_hash = {}
        fight_hash[:red_record] = fight_stats.first
        fight_hash[:blue_record] = fight_stats[2]
        fight_hash[:red_height] = fight_stats[3]
        fight_hash[:blue_height] = fight_stats[5]
        fight_hash[:red_weight] = fight_stats[6]
        fight_hash[:blue_weight] = fight_stats[8]
        #creates new fight and passes names and stat values to it
        new_fight = Concerns::EventFight.new(red_name, blue_name, fight_hash)
        #adds the fight to the Events.event_fights array
        event.event_fights << new_fight
      end
    end
  end

  def scrape_fighters

  end

end
