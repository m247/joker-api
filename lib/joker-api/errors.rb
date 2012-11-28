module JokerAPI
  class AuthorisationError < RuntimeError; end
  class ObjectNotFound < RuntimeError; end
  class IncompleteRequest < RuntimeError; end
end
