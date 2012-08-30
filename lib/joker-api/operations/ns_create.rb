require 'active_support/core_ext/hash/keys'

module JokerAPI
  module Operations
    module NsCreate
      # Create a nameserver with given IP addresses.
      #
      # @param [String] host Nameserver hostname
      # @param [Hash] ips IP Addresses
      # @option ips [String] :ipv4 IPv4 Address
      # @option ips [String] :ipv6 IPv6 Address
      # @return [Boolean] true when successful
      def ns_create(host, ips = {})
        ips.assert_valid_keys(:ipv4, :ipv6)
        raise ArgumentError, "at least one IP is required" if ips.empty?
      end
    end
  end
end
