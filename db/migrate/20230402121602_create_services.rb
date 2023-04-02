class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :name
      t.integer :price
      t.date :available_date
      t.time :available_time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end