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

        params = DEFAULT_OPTIONS.merge(options)
        extended = params.delete(:extended)

        params['extended-format'] = extended ? "1" : "0"
        params[:pattern] = pattern

        response = perform_request("query-contact-list", params)

        if response.error?
          return {} if extended
          return []
        end

        if extended
          separator = response.headers['Separator'] == 'TAB' ? "\t" : "\t" # Not sure what other separator options are available
          columns = response.headers['Columns'].split(',').map { |c| c.to_sym }

          result = {}
          response.body.each_line do |line|
            fields = line.strip.split(separator, columns.count)

            result[fields[0]] = {}
            columns.each_with_index do |name, index|
              next if index == 0
              result[fields[0]][name] = fields[index]
            end
          end

          result
        else
          response.body.split("\n")
        end
      end
    end
  end
end
