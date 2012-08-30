require 'active_support/core_ext/hash/keys'

module JokerAPI
  module Operations
    module QueryDomainList
      DEFAULT_OPTIONS = {:from => nil, :to => nil,
        :showstatus => false, :showgrants => false}
      VALID_OPTIONS = DEFAULT_OPTIONS.keys

      # @param [String] pattern Pattern to match (against handle)
      # @param [Hash] options
      # @option options [String] :from	Start from this item in list
      # @option options [String] :to	End by this item in list
      # @option options [Boolean] :showstatus (false) Include the domains status in the results
      # @option options [Boolean] :showgrants	(false) Include the domains grants in the results
      def query_domain_list(pattern, options = {})
        options.assert_valid_keys(VALID_OPTIONS)
      end
    end
  end
end
