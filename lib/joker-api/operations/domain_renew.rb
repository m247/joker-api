module JokerAPI
  module Operations
    module DomainRenew
      # @param [String] domain Domain name to renew
      # @param [Integer,#year] period_or_date Expiry date or number of months to renew the domain for
      def domain_renew(domain, period_or_date)
        options = {:domain => domain}
        if period_or_date.kind_of?(Fixnum)
          options[:period] = period_or_date.to_s
        elsif period_or_date.respond_to?(:year)
          options[:expyear] = period_or_date.year.to_s
        else
          raise ArgumentError, "period_or_date must be integer months or date with a year"
        end

        response = perform_request("domain-renew", options)
        response.success?
      end
    end
  end
end