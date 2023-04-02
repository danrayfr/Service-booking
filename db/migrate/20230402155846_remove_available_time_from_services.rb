class RemoveAvailableTimeFromServices < ActiveRecord::Migration[7.0]
  def change
    remove_column :services, :available_time
  end
end
