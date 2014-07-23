module JokerAPI
  class AuthorisationError < RuntimeError; end
  class ObjectNotFound < RuntimeError; end
  class IncompleteRequest < RuntimeError
    attr_reader :response
    def initialize(response = nil)
      super "Incomplete response from command, did not recevied acknowledgement from Joker in time"
      @response = response
    end
  end
end
