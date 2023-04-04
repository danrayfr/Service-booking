class ReceiptMailer < ApplicationMailer
  def send_receipt(user, booking)
    @user = user
    @booking = booking
    mail(to: @user.email, subject: "Booking Receipt")
  end
end
