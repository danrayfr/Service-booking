# frozen_string_literal: true

module Types
  class CartType < Types::BaseObject
    field :id, ID, null: false
    field :user, UserType, null: false
    field :cart_item, CartItemType, null: false
  end
end
