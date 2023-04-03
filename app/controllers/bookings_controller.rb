class BookingsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_bookings,  only: %i(edit update destroy)
  def index
    @services = Service.all
    @bookings = Booking.all
  end

  def show
    @service = Service.friendly.find(params[:id])
    @booking = current_user.bookings.build
  end

  def new
  end

  def create
    @booking = current_user.bookings.build(booking_params)

    respond_to do |format|
      if @booking.save
        format.html { redirect_to root_url, notice: "service booking is successfully saved." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end      
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to root_url, notice: "service booking is successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @booking.destroy
        format.html { redirect_to root_url, notice: "service booking deleted successfully!" }
      end
    end
  end

  private 

  def set_bookings
    @booking = Bookings.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:status, :user_id, :service_id, :payment_id, :booked_time, :slot, :billing_id)
  end
end 