class Address < ApplicationRecord
  belongs_to :billing

  validates :street, :barangay, :city, :zipcode, presence: true
end
