require "pry"
module Mutations
  class AddToCart < Mutations::BaseMutation
    argument :service_id, ID, required: true
    argument :slot, Int, required: true
    argument :booked_time, String, required: true

    field :cart_items, Types::CartItemType, null: true
    field :errors, [String], null: true

    def resolve(service_id:, slot:, booked_time:)
      errors = []
      user = context[:current_user]
      # binding.pry
      # Authenticate user before performing any action
      unless user
        errors <<  "You need to authenticate to perform this action."
        return { cart_items: [], errors: errors }
      end
      
      
      service = Service.find_by(id: service_id)

      if user # Assuming you are using Devise or a similar authentication gem
        @cart ||= user.cart || Cart.create(user: current_user) # Associate cart with the logged-in user
      else
        @cart ||= Cart.find_by(id: session[:cart_id]) # Fallback to session-based cart for guests
      end
    
      if @cart.nil?
        @cart = Cart.create
        session[:cart_id] = @cart.id unless user_signed_in? # Store cart_id in session only for guests
      end
      
      if service.nil?
        errors <<  "Service not found."
        return { cart_items: [], errors: errors }
      end

      
      # Find exisiting cart item for the current service and user
      current_item = @cart.cart_items.find_by(service_id: service_id)
      
      if current_item && slot > 0
        # Update existing cart item with new slot and booked time
        current_item.update(slot: slot, booked_time: booked_time)
      elsif slot <= 0
        # If slot is <= 0, delete the cart item
        current_item&.destroy
      else
        # Create a new cart item for the current service and user
        current_item = @cart.cart_items.new(user_id: user.id, service_id: service_id, slot: slot, booked_time: booked_time)
      end

      if current_item.save
        { cart_items: current_item, errors: [] }  
      else
        { cart_items: nil, errors: current_item.errors.full_messages }
      end
      
    end

  end
end