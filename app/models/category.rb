class Category < ApplicationRecord
  include ValidationConcern
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :services

  default_scope -> { order(updated_at: :desc) }
end
