class AddBillingToBooking < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :billing, null: false, foreign_key: true
  end
end
