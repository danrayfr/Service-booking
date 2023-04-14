module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :sign_in_user, mutation: Mutations::SignInUser
    field :create_book, mutation: Mutations::CreateBook
    field :create_billing, mutation: Mutations::CreateBilling
    field :add_to_cart, mutation: Mutations::AddToCart
    field :remove_from_cart, mutation: Mutations::RemoveFromCart
  end
end