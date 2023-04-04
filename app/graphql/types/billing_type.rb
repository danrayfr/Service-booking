# frozen_string_literal: true

module Types
  class BillingType < Types::BaseObject
    field :id, ID, null: false
    field :complete_address, String
    field :user, UserType, null: true, method: :user
    field :address, AddressType, null: true, method: :address
  end
end
