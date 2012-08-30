module JokerAPI
  module Operations
    module DomainDelete
      # @param [String] domain Domain name to delete
      # @param [Boolean] force Force deletion even if older than 72 hours
      # @return [Boolean] true if successful
      def domain_delete(domain, force = false)
        response = perform_request("domain-delete", {
          :domain => domain, :force => force ? "1" : "0" })
        response.success?
      end
    end
  end
end
