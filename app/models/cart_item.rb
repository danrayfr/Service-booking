class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :service
  belongs_to :cart

  def total
    service.price * slot
  end
end
