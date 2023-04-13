class AddCartToBookings < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :cart, null: false, foreign_key: true
  end
end
