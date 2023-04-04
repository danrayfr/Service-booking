# Preview all emails at http://localhost:3000/rails/mailers/receipt_mailer
class ReceiptMailerPreview < ActionMailer::Preview
  def send_receipt_preview
    user = User.first
    booking = Booking.last
    ReceiptMailer.send_receipt(user, booking)
  end
end
