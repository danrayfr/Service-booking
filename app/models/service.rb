class Service < ApplicationRecord
  include ValidationConcern
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  belongs_to :user
  belongs_to :category
  has_many :cart_items
  has_many :carts, through: :cart_items
  has_many :bookings

  validates :price, presence: true
  validates :available_date, presence: true, comparison: { greater_than: Time.zone.now, message: "must be set in the future or later." }
  validates :available_slots, presence: true
  validates :category_id, presence: true
  
  default_scope -> { order(updated_at: :desc) }
end