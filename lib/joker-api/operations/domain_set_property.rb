module JokerAPI
  module Operations
    module DomainSetProperty
      # @param [String] domain Domain name
      # @param [String] key Property name
      # @param [String] value Property value
      def domain_set_property(domain, key, value)
        response = perform_request('domain-set-property', {:domain => domain, :pname => key, :pvalue => value})
        response.success?
      end
    end
  end
end
