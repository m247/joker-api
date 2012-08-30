require 'active_support/core_ext/hash/keys'

module JokerAPI
  module Operations
    module ContactCreate
      # @param [Hash] fields
      # @option fields [String] :tld TLD where this contact is to be used.
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
      def contact_create(fields = {})

      end
    end
  end
end
