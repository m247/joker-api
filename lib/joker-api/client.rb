require 'httparty'
require 'active_support/core_ext/object/blank'

require File.expand_path('../errors', __FILE__)
require File.expand_path('../operations', __FILE__)

module JokerAPI
  class Client
    include HTTParty

    attr_reader :balance, :tlds

    def initialize(username, password, host = 'dmapi.joker.com', options = {})
      @username, @password = username, password
      @default_options = options.merge(:base_uri => HTTParty.normalize_base_uri("https://#{host}"))

      @auth_sid = nil
      @balance = 0.00
      @tlds = []
    end

    def inspect
      "#<#{self.class.name} #{@default_options[:base_uri]} (#{@username})#{@auth_sid && " logged in"}>"
    end

    def login
      response = perform_request('login', {:username => @username, :password => @password})

      @auth_sid = response.auth_sid
      @balance = response.account_balance
      @tlds = response.body.split("\n").sort

      self
    end

    # Returns the last response received.
    # @return [Response]
    def last_response
      @response
    end

    # Returns the last error received from a response
    # @return [Response::Error]
    def last_error
      @last_error
    end

    # Returns the number of seconds the last request/response took
    # @return [Float]
    def response_time
      @response_time
    end

    include Operations::QueryContactList
    include Operations::ContactCreate
    include Operations::ContactDelete
    include Operations::ContactModify

    include Operations::QueryDomainList
    include Operations::DomainDelete

    include Operations::DomainLock
    include Operations::DomainUnlock

    include Operations::QueryNsList
    include Operations::NsCreate
    include Operations::NsDelete
    include Operations::NsModify

    include Operations::QueryWhois

    include Operations::ResultRetrieve

    protected
      def default_options
        @default_options
      end
      def perform_request(path, query = {})
        path = "/request/#{path}"
        options = default_options.dup

        query = query.reject { |_,v| v.blank? }

        begin
          query = query.merge('auth-sid' => @auth_sid) if @auth_sid
          options = options.merge(:query => query) unless query.empty?

          response_data = stopwatch do
            self.class.get(path, options)
          end

          @response = Response.new(response_data)
          store_response_information(@response)

          @response
        rescue AuthorisationError
          login
          retry
        end
      end
      def store_response_information(response)
        @last_error = response.error if response.error?
        @balance = response.account_balance || @balance
      end

      def stopwatch
        start = Time.now.utc.to_f
        result = yield
        @response_time = Time.now.utc.to_f - start
        return result
      end
  end
end
