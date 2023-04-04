class Receipt < ApplicationRecord
  belongs_to :user
  # belongs_to :billing
  belongs_to :booking
end