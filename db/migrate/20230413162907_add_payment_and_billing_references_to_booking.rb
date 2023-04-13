class AddPaymentAndBillingReferencesToBooking < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :payment, null: false, foreign_key: true
    add_reference :bookings, :billing, null: false, foreign_key: true
  end
end
