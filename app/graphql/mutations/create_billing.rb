require "pry"
module Mutations
  class CreateBilling < BaseMutation
    argument :street, String, required: true
    argument :barangay, String, required: true
    argument :city, String, required: true
    argument :province, String, required: true
    argument :zipcode, Integer, required: true

    field :billing, Types::BillingType, null: false
    field :errors, [String], null: false

    def resolve(street: nil, barangay: nil, city: nil, province: nil, zipcode: nil)
      errors = []
      user = context[:current_user]

      unless user
        errors << "User must be authenticated to book"
        return { billing: [], errors: errors }
      end
      
      # binding.pry

      billing = user.billings.build(
        address_attributes: {
          street: street,
          barangay: barangay,
          city: city,
          province: province,
          zipcode: zipcode,
          user_id: user.id
        }
      )
      
      billing.complete_address = billing.address.attributes.values_at(*%w[street barangay city, zipcode]).join(', ')

      if billing.save
        { billing: billing, errors: [] }
      else
        { billing: nil, errors: billing.errors.full_messages }
      end
    end
  end
end