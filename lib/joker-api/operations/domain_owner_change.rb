require 'active_support/core_ext/hash/keys'

module JokerAPI
  module Operations
    module DomainOwnerChange
      # @param [String] domain Domain name to change the owner of
      # @param [Hash] fields New owner fields
      # @option fields [String] :name Full name, if blank :fname and :lname will be used
      # @option fields [String] :fname First name, required if :name is blank
      # @option fields [String] :lname Last name, required if :name is blank
      # @option fields [String] :title Mr, Mrs, Ms. Optional field.
      # @option fields [Boolean] :individual Whether the contact is an individual or an organisation
      # @option fields [String] :organization Organisation name, Optional if :individual is true.
      # @option fields [String] :email Contacts email address
      # @option fields [String] :address Contact Postal Address
      # @option fields [String] :city Postal City
      # @option fields [String] :state Postal State or Locale. Optional field.
      # @option fields [String] :postal_code Postal Code
      # @option fields [String] :country ISO3166 country code
      # @option fields [String] :phone Telephone number in ITU format
      # @option fields [String] :extension Telephone extension. Optional field.
      # @option fields [String] :fax Fax number. Optional field.
      def domain_owner_change(domain, fields = {})
        raise ArgumentError, ":organization required if :individual is false" if fields[:individual] && fields[:individual] == false && fields[:organization].blank?
        raise ArgumentError, ":name or :fname and :lname are required" if fields[:name].blank? && fields[:fname].blank? && fields[:lname].blank?

        [:email, :address, :city, :postal_code, :country, :phone].each do |field|
          raise ArgumentError, "field :#{field} is required" if fields[field].blank?
        end

        fields = fields.dup

        fields['individual'] = fields.delete(:individual) ? 'Y' : 'N'
        fields['postal-code'] = fields.delete(:postal_code)

        Array(fields.delete(:address)).each_with_index do |addr, idx|
          break if idx > 2
          fields["address-#{idx + 1}"] = addr
        end

        response = perform_request('domain-owner-change', fields.merge(:domain => domain))
        response.success?
      end
    end
  end
end
