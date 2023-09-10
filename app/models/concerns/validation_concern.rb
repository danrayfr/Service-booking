module ValidationConcern
  extend ActiveSupport::Concern

  included do 
    has_rich_text :description
    has_one_attached :image

    validates :name, presence: true, uniqueness: true
    validates :description, presence: true, length: { maximum: 255 }
    validates :image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']
    validates :image, size: { less_than: 5.megabytes , message: 'should less than 5MB.' }
    
  end
end