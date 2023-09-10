class CategoryService
  
  def initialize(category_params)
    @category_params = category_params
  end

  def create_category
    @category = Category.new(@category_params)

    if @category.save
      return { success: true, message: "Category was successfully created." }
    else
      return { success: false, errors: @category.errors, message: "Failed to create category." }
    end
  end

  def update_category(category)
    if category.update(@category_params)
      return { success: true, message: "Category was successfully updated." }
    else
      return { success: false, errors: @category.errors, message: "Failed to update category." }
    end
  end

  def destroy_category(category)
    if category.destroy
      return { success: true, message: "Category was successfully destroyed." }
    else
      return { success: false, errors: @category.errors, message: "Failed to delete category." }
    end
  end
  
end