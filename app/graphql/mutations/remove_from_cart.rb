require "pry"
module Mutations
  class RemoveFromCart < Mutations::BaseMutation
    argument :cart_item_id, ID, required: true

    field :cart_items, Types::CartItemType, null: true
    field :errors, [String], null: true

    def resolve(cart_item_id:)
      errors = []
      user = context[:current_user]
      # Authenticate user before performing any action
      
      unless user
        errors <<  "You need to authenticate to perform this action."
        return { cart_items: [], errors: errors }
      end
      
      

      if user # Assuming you are using Devise or a similar authentication gem
        @cart ||= user.cart || Cart.create(user: current_user) # Associate cart with the logged-in user
      else
        @cart ||= Cart.find_by(id: session[:cart_id]) # Fallback to session-based cart for guests
      end
    
      if @cart.nil?
        @cart = Cart.create
        session[:cart_id] = @cart.id unless user_signed_in? # Store cart_id in session only for guests
      end

      cart_item = @cart.cart_items.find_by(id: cart_item_id)

      binding.pry
      
      if cart_item.nil? 
        errors << "Cart item not found."
        return { cart_items: [], errors: errors }
      end

      if cart_item.destroy
        { cart_items: cart_item, errors: [] }
      else
        { cart_items: [], errors: cart_item.errors.full_messages }
      end
    
    end
  end

end