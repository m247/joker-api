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

        params = DEFAULT_OPTIONS.merge(options) # options are essentially dup'd here
        params[:pattern] = pattern
        params[:showgrants] = params[:showgrants] ? "1" : "0"
        params[:showstatus] = params[:showstatus] ? "1" : "0"

        response = perform_request("query-domain-list", params)

        result = {}
        return result if response.error?

        separator = " "
        columns = response.headers['Columns'].split(',').map { |c| c.to_sym }

        response.body.each_line do |line|
          fields = line.strip.split(separator, columns.count)

          data = {}
          columns.each_with_index do |name, index|
            next if index == 0
            data[name] = fields[index]
          end

          # Post-processing
          data[:expiration_date] = Time.parse(data[:expiration_date]).utc

          if data.has_key?(:invitation_possible)
             data[:invitation_possible] = data[:invitation_possible] == "true"
           end

          if data.has_key?(:number_of_confirmed_grants)
            data[:number_of_confirmed_grants] = data[:number_of_confirmed_grants].to_i
          end

          result[fields[0]] = data
        end

        result
      end
    end
  end
end
