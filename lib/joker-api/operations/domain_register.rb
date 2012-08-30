require 'active_support/core_ext/hash/keys'

module JokerAPI
  module Operations
    module DomainRegister
      DEFAULT_OPTIONS = { :status => %(production), :period => 12 } # period in months
      VALID_OPTIONS = DEFAULT_OPTIONS.keys + [:owner_c, :billing_c, :admin_c, :tech_c, :ns_list]

      # @param [String] domain Domain name to register
      # @param [Hash] options
      # @option options [String] :owner_c Owner contact handle
      # @option options [String] :billing_c Billing contact handle
      # @option options [String] :admin_c Administrative contact handle
      # @option options [String] :tech_c Technical contact handle
      # @option options [Array<String>] :ns_list List of nameservers to use
      def domain_register(domain, options = {})
        options.assert_valid_keys(VALID_OPTIONS)
        options = DEFAULT_OPTIONS.merge(options)

        # TODO: assert all VALID_OPTIONS keys are present
        # TODO: check domain TLD is one of self#tlds

        ns_list = options.delete(:ns_list).join(":")
      end
    end
  end
end
