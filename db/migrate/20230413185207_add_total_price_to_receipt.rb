class AddTotalPriceToReceipt < ActiveRecord::Migration[7.0]
  def change
    add_column :receipts, :total_amount, :integer, default: 0
  end
end
