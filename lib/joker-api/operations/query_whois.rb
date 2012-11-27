require 'active_support/core_ext/hash/keys'

module JokerAPI
  module Operations
    module QueryWhois
      OBJECT_NOT_FOUND_CODE = 2303

      # Returns information about the specified object in key: value form.
      #
      # @note Only objects registered with Joker.com will be queried.
      # @note Only one object may be requested at once.
      #
      # @param [Hash<Symbol,String>] query The query to obtain results for
      # @options query [String] :domain Domain name to query
      # @options query [String] :contact Contact handle to query
      # @options query [String] :host Nameserver address to query
      # @return [Hash] Information about the requested object.
      #
      # @raise [ArgumentError] if more than one key or the key not one of :domain, :contact or :host.
      # @raise [ObjectNotFound] if the object does not exist in the Joker.com registry
      def query_whois(query)
        query.assert_valid_keys(:domain, :contact, :host)
        raise ArgumentError, "only one object may be requested at once" unless query.length == 1

        response = perform_request('query-whois', query)

        if response.error? && response.error.code == OBJECT_NOT_FOUND_CODE
          raise ObjectNotFound, "#{query.keys[0]} object: #{query.values[0]} not found"
        end

        result = {}
        response.body.each_line do |line|
          key, value = line.strip.split(": ", 2)
          key = key.sub("#{query.keys[0]}.", '')

          if key =~ /\.date$/
            key = key.sub(".date", "")
            value = Time.parse(value)
          elsif key =~ /expires$/
            value = Time.parse(value)
          elsif key =~ /nservers\.nserver\.handle$/
            key = "nservers"
          elsif key =~ /nservers\.nserver\.no$/
            next
          end

          value = Array(result[key]) + [value] if result.has_key?(key)
          result.store(key, value)
        end

        result
      end
    end
  end
end
