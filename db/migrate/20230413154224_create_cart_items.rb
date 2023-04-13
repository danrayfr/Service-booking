class CreateCartItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :service, null: false, foreign_key: true
      t.belongs_to :cart, null: false, foreign_key: true
      t.time :booked_time
      t.integer :slot

      t.timestamps
    end
  end
end
