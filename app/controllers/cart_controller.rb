require "pry"
class CartController < ApplicationController
  before_action :authenticate_user!

  def show
    @render_cart = false
  end

  def add
    @service = Service.find_by(id: params[:service_id])
    slot = params[:slot].to_i
    booked_time = params[:booked_time]
  
    current_item = @cart.cart_items.find_by(service_id: @service&.id)
    
    # binding.pry
    
    if current_item && slot > 0
      current_item.update(slot: slot, booked_time: booked_time, user_id: current_user.id)
    elsif slot <= 0
      current_item.destroy
    else
      @cart.cart_items.create(user_id: current_user.id, service_id: @service&.id, booked_time: booked_time, slot: slot)
    end
  
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Added to cart" }
    end
  end

  def remove
    CartItem.find_by(id: params[:id]).destroy
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("cart", partial: "cart/cart", locals: { cart: @cart })
      end
    end
  end
end