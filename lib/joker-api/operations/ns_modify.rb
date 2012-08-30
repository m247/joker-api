require 'active_support/core_ext/hash/keys'

module JokerAPI
  module Operations
    module NsModify
      # Change nameserver IP addresses.
      #
      # @param [String] host Nameserver hostname
      # @param [Hash] ips IP Addresses
      # @option ips [String] :ipv4 IPv4 Address
      # @option ips [String] :ipv6 IPv6 Address
      # @return [Boolean] true when successful
      def ns_modify(host, ips = {})
        ips.assert_valid_keys(:ipv4, :ipv6)
        raise ArgumentError, "at least one IP is required" if ips.empty?

        # Check IP addresses to make sure they're valid, will raise ArgumentError
        ips[:ipv4] && IPAddr.new(ips[:ipv4], Socket::AF_INET)
        ips[:ipv6] && IPAddr.new(ips[:ipv6], Socket::AF_INET6)

        response = perform_request("ns-modify", {
          :host => host, :ip => ips[:ipv4], :ipv6 => ips[:ipv6]})
        response.success?
      end
    end
  end
end
