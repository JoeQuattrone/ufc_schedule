class Concerns::Events
  attr_accessor :id, :title, :tag_line, :date, :time, :arena, :location, :event_fights

  @@all = []

  def self.new_from_api(events)
    #parses future and past ufc events and only creates objects of events that are happening in the future
    if Time.parse(events["event_date"]) >= Time.now == true
      self.new(
        events["id"],
        events["base_title"],
        events["title_tag_line"],
        events["event_date"],
        events["subtitle"],
        events["arena"],
        events["location"]
      )
    end
  end

  def initialize(id = nil, title = nil, tag_line = nil, date = nil, how_to_watch = nil, arena = nil,location = nil)
    @id = id
    @title = title
    @tag_line = tag_line
    @date = date
    @how_to_watch = how_to_watch
    @location = location
    @event_fights = []
    @@all << self
  end

  def self.all
    @@all
  end

  def self.list_events
    #1. UFC 232: Jones vs Gustafsson 2 - December 29, 2018. Las Vegas, Nevada.
    self.all.each_with_index do |event, index|
      puts "#{index + 1}. #{event.title}: #{event.tag_line} - #{self.fix_date(event)}. #{self.determine_location(event)}."
    end
  end

  def self.determine_location(event)
    #sets location to "TBD" if location is empty
     event.location.empty? ? "TBD" : event.location
  end

  def self.fix_date(event)
    #parses through the event's date and changes it to a more readable format. Ex: January 19, 2019
    Time.parse(event.date).strftime("%B %d, %Y")
  end

end
