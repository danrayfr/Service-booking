class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items
  has_many :services, through: :cart_items

  def total 
    cart_items.to_a.sum { |cart_item| cart_item.total }
  end
end
