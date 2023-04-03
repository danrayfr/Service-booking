class AddDetailsToBooking < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :booked_time, :time
    add_column :bookings, :slot, :integer
  end
end
