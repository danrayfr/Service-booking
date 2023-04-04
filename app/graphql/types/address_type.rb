# frozen_string_literal: true

module Types
  class AddressType < Types::BaseObject
    field :id, ID, null: false
    field :street, String
    field :barangay, String
    field :city, String
    field :province, String
    field :zipcode, Integer
  end
end
