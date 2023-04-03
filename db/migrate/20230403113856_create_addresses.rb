class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :barangay
      t.string :city
      t.string :province
      t.integer :zipcode
      t.references :billing, null: false, foreign_key: true

      t.timestamps
    end
  end
end
