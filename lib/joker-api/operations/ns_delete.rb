module JokerAPI
  module Operations
    module NsDelete
      # Deletes a nameserver from Joker.com
      #
      # @param [String] host Hostname of the nameserver to delete
      # @return [Boolean] true when successful
      def ns_delete(host)
        response = perform_request("ns-delete", {:host => host})
        response.success?
      end
    end
  end
end
