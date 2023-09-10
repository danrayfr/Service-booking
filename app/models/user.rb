class User < ApplicationRecord
  include UserConcern

  has_many :services, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :billings, dependent: :destroy
  has_many :receipts, dependent: :destroy
  has_one :cart, dependent: :destroy
end