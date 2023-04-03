class Address < ApplicationRecord
  belongs_to :billing

  validates :street, :barangay, :city, :province, :zipcode, presence: true
end
