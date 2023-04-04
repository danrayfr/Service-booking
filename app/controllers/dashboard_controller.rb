class DashboardController < ApplicationController
  def index
    @bookings = Booking.all
    @users = User.all
    @services = Service.all
    @billings = Billing.all
    @payments = Payment.all
    @categories = Category.all
    @receipts = Receipt.all
  end

  def bookings
    @bookings = Booking.all
  end

  def users
    @users = User.all
  end

  def services
    @services = Service.all
  end

  def billings
    @billings = Billing.all
  end

  def payments 
    @payments = Payment.all
  end

  def categories
    @categories = Category.all
  end

  def receipts
    @receipts = Receipt.all
  end
end
