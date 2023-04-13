class RemovePaymentAndBillingReferencesFromBookings < ActiveRecord::Migration[7.0]
  def change
    remove_reference :bookings, :payment, null: false, foreign_key: true
    remove_reference :bookings, :billing, null: false, foreign_key: true
  end
end
bo