require 'active_support/core_ext/hash/keys'

module JokerAPI
  module Operations
    module DomainTransferIn
      EXTENDED_OPTIONS = [:admin_c, :tech_c, :owner_email, :status, :period]
      VALID_OPTIONS = [:billing_c] + EXTENDED_OPTIONS

      # @param [String] domain Domain to transfer into Joker
      # @param [String] auth_key EPP Authorisation key for the transfer
      # @param [Hash] options
      # @option options [String] :billing_c Billing contact handle
      # @option options [String] :admin_c Admin contact handle
      # @option options [String] :tech_c Technical contact handle
      # @option options [String] :owner_email New email address for owner contact
      # @option options [String] :status Domain status to be set after transfer
      # @option options [Integer] :period Renewal period in months. (Currently ignored.)
      def domain_transfer_in(domain, auth_key, options = {})
        options.assert_valid_keys(VALID_OPTIONS)
        command = options.slice(EXTENDED_OPTIONS).empty? ?
          'domain-transfer-in' : 'domain-transfer-in-reseller'
      end
    end
  end
end
