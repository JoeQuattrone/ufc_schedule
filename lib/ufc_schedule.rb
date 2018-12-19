require 'pry'
require 'nokogiri'
require 'open-uri'
require 'rest-client'
require 'json'
module Concerns
end
require_relative "api"
require_relative "./shared_methods/shared_cli_methods"
require_relative "./ufc_schedule/version"
require_relative "command_line_interface"
require_relative "events"
require_relative "fighter"
require_relative "event_fight"
