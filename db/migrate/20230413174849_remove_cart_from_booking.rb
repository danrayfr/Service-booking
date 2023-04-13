class RemoveCartFromBooking < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookings, :cart_id
  end
end
