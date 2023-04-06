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
    @bookings = Booking.all.includes(:payment, :user, service: [image_attachment: :blob])
  end

  def users
    @users = User.all
  end

  def services
    @services = Service.all.includes(:category, :rich_text_description, image_attachment: :blob)
  end

  def billings
    @billings = Billing.all.includes(:user)
  end

  def payments 
    @payments = Payment.all
  end

  def categories
    @categories = Category.all.includes(:rich_text_description, image_attachment: :blob)
  end

  def receipts
    @receipts = Receipt.all.includes(:user, booking: [:service, :payment])
  end
end
