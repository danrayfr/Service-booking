class ReceiptMailer < ApplicationMailer
  def send_receipt(user, receipt)
    @user = user
    @receipt = receipt
    mail(to: @user.email, subject: "Booking Receipt")
  end
end
