require 'httparty'

require File.expand_path('../errors', __FILE__)

module JokerAPI
  class Client
    include HTTParty

    def initialize(username, password, host = 'dmapi.joker.com', options = {})
      @username, @password = username, password
      @default_options = options.merge(:base_uri => HTTParty.normalize_base_uri("https://#{host}"))

      @auth_sid = nil
    end

    def inspect
      "#<#{self.class.name} #{@default_options[:base_uri]} (#{@username})#{@auth_sid && " logged in"}>"
    end
  end
end
