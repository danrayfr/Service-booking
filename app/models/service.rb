class Service < ApplicationRecord
  extend FriendlyId
  default_scope -> { order(updated_at: :desc) }
  friendly_id :name, use: :slugged
  has_rich_text :description
  has_one_attached :image

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: { maximum: 255 }
  validates :image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']
  validates :image, size: { less_than: 5.megabytes , message: 'should less than 5MB.' }

  validates :available_date, presence: true, comparison: { greater_than: Time.zone.now, message: "must be set in the future or later." }
  validates :available_slots, presence: true
  validates :category_id, presence: true

  belongs_to :user
  belongs_to :category
  has_many :slots
  has_many :bookings, dependent: :destroy
end
