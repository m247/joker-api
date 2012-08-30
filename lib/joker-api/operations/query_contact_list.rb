require 'active_support/core_ext/hash/keys'

module JokerAPI
  module Operations
    module QueryContactList
      DEFAULT_OPTIONS = {:from => nil, :to => nil,
        :tld => nil, :extended => false}
      VALID_OPTIONS = DEFAULT_OPTIONS.keys

      # @param [String] pattern Pattern to match (against handle)
      # @param [Hash] options
      # @option options [String] :from	Start from this item in list
      # @option options [String] :to	End by this item in list
      # @option options [String] :tld Limits output to contact handles which may be used
      #                               with specified toplevel domain (tld), like "com".
      # @option options [Boolean] :extended	(false) Provides additional information for every
      #                                     contact listed: name & organization.
      # @return [Array,Hash] When :extended is false an array of contact handles is returned,
      #                      when :extended is true a hash of contact information is returned
      #                      keyed by contact handle.
      #
      # @raise [ArgumentError] if any of the passed option keys are not valid
      def query_contact_list(pattern, options = {})
        options.assert_valid_keys(VALID_OPTIONS)
      end
    end
  end
end
