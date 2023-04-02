class AddAvailableSlotsToService < ActiveRecord::Migration[7.0]
  def change
    add_column :services, :available_slots, :jsonb, default: [], array: true
  end
end
