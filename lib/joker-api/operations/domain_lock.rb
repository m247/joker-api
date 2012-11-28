module JokerAPI
  module Operations
    module DomainLock
      # @param [String] domain Domain name to lock
      def domain_lock(domain)
        response = perform_request('domain-lock', :domain => domain)
        response.success?
      end
    end
  end
end