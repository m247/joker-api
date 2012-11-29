module JokerAPI
  module Operations
    module DomainTransferGetAuthId
      def domain_transfer_get_auth_id(domain)
        response = perform_request('domain-transfer-get-auth-id', :domain => domain)
        return false unless response.success?

        wait_for_result(response) do |result|
          if result["Object-Name"] == domain
            if result["body"] =~ /The Authorization ID is: "([^"]+)"/
              return $1
            else
              return false
            end
          end
        end
      end
    end
  end
end
