module JokerAPI
  module Operations
    module ContactDelete
      # @param [String] handle Contact handle to be deleted
      def contact_delete(handle)
        response = perform_request("contact-delete", :handle => handle)
        response.success?
      end
    end
  end
end
