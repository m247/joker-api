require 'active_support/core_ext/hash/keys'

module JokerAPI
  module Operations
    module DomainModify
      VALID_OPTIONS = [:billing_c, :admin_c, :tech_c, :ns_list, :dnssec]

      # @param [String] domain Domain name to modify
      # @param [Hash] options
      # @option options [String] :billing_c New Billing contact handle
      # @option options [String] :admin_c New Admin contact handle
      # @option options [String] :tech_c New Technical contact handle
      # @option options [Array<String>] :ns_list New list of nameservers
      # @option options [Array<String>,Boolean] :dnssec Set to false to remove DNSSEC.
      #                 The string values should be tag:alg:digest-type:digest for com/net/org/tv/cc
      #                 For .de domains the values should be protocol:alg:flags:pubkey-base64
      def domain_modify(domain, options = {})
        options.assert_valid_keys(VALID_OPTIONS)
        return true if options.empty?

        options["tech-c"] = options.delete(:tech_c)
        options["admin-c"] = options.delete(:admin_c)
        options["billing-c"] = options.delete(:billing_c)

        options["ns-list"] = options.delete(:ns_list).join(":")

        dnssec = options.delete(:dnssec)
        options["dnssec"] = "0" if dnssec == false

        if dnssec
          options["dnssec"] = "1"
          dnssec.each_with_index do |obj, idx|
            break if idx > 5 # not allowed more than 6 entries
            options["ds-#{idx+1}"] = obj
          end
        end

        response = perform_request('domain-modify', options.merge(:domain => domain))
        response.success?
      end
    end
  end
end
