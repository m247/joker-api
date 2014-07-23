module JokerAPI
  class AuthorisationError < RuntimeError; end
  class ObjectNotFound < RuntimeError; end
  class IncompleteRequest < RuntimeError
    attr_reader :response
    def initialize(message, response = nil)
      super message
      @response = response
    end
  end
end
