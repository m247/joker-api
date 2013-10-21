require 'active_support/core_ext/hash/keys'

module JokerAPI
  module Operations
    module DomainTransferIn
      EXTENDED_OPTIONS = [:admin_c, :tech_c, :owner_email, :status, :period, :autorenew, :ns_list]
      VALID_OPTIONS = [:billing_c] + EXTENDED_OPTIONS

      # Performs a 'domain-transfer-in' or 'domain-transfer-in-reseller' depending
      # on the options given to the method.
      #
      # @param [String] domain Domain to transfer into Joker
      # @param [String] auth_key EPP Authorisation key for the transfer
      # @param [Hash] options
      # @option options [String] :billing_c Billing contact handle
      # @option options [String] :admin_c Admin contact handle
      # @option options [String] :tech_c Technical contact handle
      # @option options [String] :owner_email New email address for owner contact
      # @option options [String] :status Domain status to be set after transfer
      # @option options [Integer] :period Renewal period in months. (Currently ignored.)
      # @option options [Boolean] :autorenew (true) Sets the autorenew option on the domain. Default imposed by Joker.com.
      # @option options [Array<String>] :ns_list List of nameservers to set on the domain
      def domain_transfer_in(domain, auth_key, options = {})
        options.assert_valid_keys(VALID_OPTIONS)
        options = options.dup
        command = options.slice(EXTENDED_OPTIONS).empty? ?
          'domain-transfer-in' : 'domain-transfer-in-reseller'

        # Currently ignored, Joker.com says to leave it empty
        options.delete(:period)

        options["billing-c"] = options.delete(:billing_c)
        options["admin-c"] = options.delete(:admin_c)
        options["tech-c"] = options.delete(:tech_c)
        options["owner-email"] = options.delete(:owner_email)

        if options.has_key?(:ns_list)
          options["ns-list"] = options.delete(:ns_list).join(":")
        end

        response = perform_request(command, options.merge(:domain => domain, 'transfer-auth-id' => auth_key))
        return response.proc_id if response.success?
        return false
      end
    end
  end
end
