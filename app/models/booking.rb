class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :service
  belongs_to :payment

  enum status: { pending: 0, approved: 1, cancelled: 2 }
end