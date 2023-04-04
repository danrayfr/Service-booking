module Mutations
  class CreateBilling < BaseMutation
    null true

    argument :street, String, required: true
    argument :barangay, String, required: true
    argument :city, String, required: true
    argument :province, String, required: true
    argument :zipcode, Integer, required: true

    field :billing, Types::BillingType, null: true
    field :errors, [String], null: false

    def resolve(street:, barangay:, city:, province:, zipcode:)
      user = context[:current_user]

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
