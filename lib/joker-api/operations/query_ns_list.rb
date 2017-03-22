module JokerAPI
  module Operations
    module QueryNsList
      # Returns list of nameservers matching +pattern+.
      #
      # Results are returned as an array of hashes, the hashes
      # contain a +:name+ key specifying the hostname of the
      # matching nameserver. If the +full+ option was set to
      # +true+ then the additional +ipv4+ and +ipv6+ keys will
      # be included in the hash.
      #
      # @param [String] pattern Hostname or wildcard pattern
      # @param [Boolean] full Include IPs in list info
      # @return [Array,Hash] Array of nameserver names if +full+ is false, otherwise
      #                      a Hash of nameservers keyed by name is returned with the
      #                      IP address details as values of the hash.
      def query_ns_list(pattern, full = false)
        response = perform_request('query-ns-list',
          :pattern => pattern,
          :full    => full ? '1' : '0')

        results = full ? {} : []
        # TODO: response.body can be nil here, what does that mean?
        response.body.each_line do |line|
          name, ipv4, ipv6 = line.strip.split("\t", 3)

          ipv4 = nil if ipv4 && ipv4 == '-'
          ipv6 = nil if ipv6 && ipv6 == '-'

          if full
            results[name] = { :ipv4 => ipv4, :ipv6 => ipv6 }
          else
            results << name
          end
        end

        results
      end
    end
  end
end
