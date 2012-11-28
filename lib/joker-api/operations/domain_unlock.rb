module JokerAPI
  module Operations
    module DomainUnlock
      # @param [String] domain Domain name to unlock
      def domain_unlock(domain)
        response = perform_request('domain-unlock', :domain => domain)
        response.success?
      end
    end
  end
end
