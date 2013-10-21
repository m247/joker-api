require 'active_support/core_ext/hash/keys'

module JokerAPI
  module Operations
    module ContactModify
      # @param [String] handle Contact handle to be modified
      # @param [Hash] fields Fields on the contact to be changed. All optional.
      # @option fields [String] :name Full name, if blank :fname and :lname will be used
      # @option fields [String] :fname First name, required if :name is blank
      # @option fields [String] :lname Last name, required if :name is blank
      # @option fields [String] :title Mr, Mrs, Ms
      # @option fields [Boolean] :individual Whether the contact is an individual or an organisation
      # @option fields [String] :organization Organisation name, Optional if :individual is true.
      # @option fields [String] :email Contacts email address
      # @option fields [String] :address Contact Postal Address
      # @option fields [String] :city Postal City
      # @option fields [String] :state Postal State or Locale
      # @option fields [String] :postal_code Postal Code
      # @option fields [String] :country ISO3166 country code
      # @option fields [String] :phone Telephone number in ITU format
      # @option fields [String] :extension Telephone extension
      # @option fields [String] :fax Fax number
      def contact_modify(handle, fields = {})
        fields.assert_valid_keys(:name, :fname, :lname, :title, :individual, :organization, :email, :address, :city, :state, :postal_code, :country, :phone, :extension, :fax)

        fields = fields.dup

        fields['individual'] = fields.delete(:individual) ? 'Y' : 'N'
        fields['postal-code'] = fields.delete(:postal_code)

        Array(fields.delete(:address)).each_with_index do |addr, idx|
          break if idx > 2
          fields["address-#{idx + 1}"] = addr
        end

        response = perform_request('contact-modify', fields.merge(:handle => handle))
        response.success?
      end
    end
  end
end
