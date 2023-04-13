require "pry"
class BookingsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_booking,  only: %i(edit update destroy)
  def index
    @services = Service.all.includes(:category, :rich_text_description, image_attachment: :blob)
    @bookings = Booking.all.includes(:service)
  end

  def show
    @service = Service.friendly.find(params[:id])
    @booking = current_user.bookings.build
  end

  def new
    @booking = Booking.new
    @cart_id = params[:cart] # Retrieve cart id from params
    @cart = Cart.find(@cart_id) # Find cart based on cart id
  end
  
  def create
    # Iterate through cart items
    @cart.cart_items.each do |cart_item|
      # Build Booking object for each cart item
      @booking = current_user.bookings.build(booking_params)
  
      # Set service_id, booked_time, and slot from cart_item
      @booking.service_id = cart_item.service_id
      @booking.booked_time = cart_item.booked_time
      @booking.slot = cart_item.slot
  
      if @booking.save
        receipt = Receipt.new(user: current_user, booking_id: @booking.id, total_amount: @cart.total)
        receipt.save
        ReceiptMailer.send_receipt(current_user, receipt).deliver_now
      else
        # Render error message and stop processing further items if saving fails for any item
        render :new, status: :unprocessable_entity
        return
      end
    end
  
    # Redirect after saving all bookings
    redirect_to root_path, notice: "Bookings saved successfully."

    @cart.cart_items.where(user: current_user).delete_all
  end

  def edit; end

  def update
    respond_to do |format|
      if @booking.update(booking_params)
        Receipt.update(user: current_user, booking_id: @booking.id)
        format.html { redirect_to dashboard_bookings_url, notice: "service booking is successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @booking.destroy
        format.html { redirect_to dashboard_bookings_url, notice: "service booking deleted successfully!" }
      end
    end
  end

  private 

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:status, :user_id, :billing_id, :payment_id, :service_id, :booked_time, :slot)
  end
end 