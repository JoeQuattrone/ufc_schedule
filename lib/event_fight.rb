class Concerns::EventFight
  attr_accessor :red_name, :red_record, :red_weight, :red_height, :blue_name, :blue_record, :blue_weight, :blue_height, :event, :fights

  @@all = []

  def initialize(red_name = nil,  blue_name = nil, fight_hash = nil)
    @red_name = red_name
    @blue_name = blue_name
    fight_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    @@all << self
  end

  def self.all
    @@all
  end

  def self.clear
    @@all.clear
  end

end
