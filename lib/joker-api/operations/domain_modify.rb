require 'active_support/core_ext/hash/keys'

module JokerAPI
  module Operations
    module DomainModify
      VALID_OPTIONS = [:billing_c, :admin_c, :tech_c, :ns_list, :dnssec]
      SUPPORTED_TLDs = /\.(com|net|org|tv|cc|de)$/

      # @param [String] domain Domain name to modify
      # @param [Hash] options
      # @option options [String] :billing_c New Billing contact handle
      # @option options [String] :admin_c New Admin contact handle
      # @option options [String] :tech_c New Technical contact handle
      # @option options [Array<String>] :ns_list New list of nameservers
      # @option options [Array,Boolean] :dnssec Set to false to remove DNSSEC.
      def domain_modify(domain, options = {})
        raise ArgumentError, "modification not supported for this domain" unless domain =~ SUPPORTED_TLDs
        options.assert_valid_keys(VALID_OPTIONS)
      end
    end
  end
end
