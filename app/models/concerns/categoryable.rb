module Categoryable
  extend ActiveSupport::Concern

  included do 
    before_action :categories, only: %i(new create edit update)
  end

  def categories
    @categories = Category.all.order(:name)
  end

end