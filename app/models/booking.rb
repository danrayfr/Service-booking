class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :service
  belongs_to :payment
  belongs_to :billing
  has_many :receipts, dependent: :destroy

  validates :user, presence: true
  validates :service, presence: true
  validates :payment, presence: true

  enum status: { pending: 0, served: 1, cancelled: 2 }
end