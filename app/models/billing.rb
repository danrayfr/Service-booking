class Billing < ApplicationRecord
  belongs_to :user
  belongs_to :booking
  has_one :address, dependent: :destroy, inverse_of: :billing
  accepts_nested_attributes_for :address
end
