# frozen_string_literal: true

module Types
  class CartItemType < Types::BaseObject
    field :id, ID, null: false
    field :booked_time, String
    field :slot, Integer
    field :user, Types::UserType, null: false
    field :service, Types::ServiceType, null: false
    field :cart, Types::CartType, null: false
  end
end
