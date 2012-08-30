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

      end
    end
  end
end
