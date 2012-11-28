module JokerAPI
  module Operations
    module DomainGetProperty
      # @param [String] domain Domain name
      # @param [String] key Property name
      def domain_get_property(domain, key)
        response = perform_request('domain-get-property', {:domain => domain, :pname => key})
        properties = response.body.split("\n").inject({}) do |hash, property|
          hash.store(*property.split(": ", 2))
          hash
        end

        properties[key]
      end
    end
  end
end
