module JokerAPI
  module Operations
    module DomainRenew
      # @param [String] domain Domain name to renew
      # @param [Integer] period Number of months to renew the domain for
      def domain_renew(domain, period)
        raise ArgumentError, "period must be integer" unless period.kind_of?(Fixnum)

        response = perform_request("domain-renew", {
          :domain => domain, :period => period.to_s })

        # need to know what the response contents actually are
        @domain_renew_response = response # for inspection purposes
        response.success?
      end
    end
  end
end