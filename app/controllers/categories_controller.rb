class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :admin_user
  before_action :set_category, only: %i(show edit update destroy)
  
  def index
    @categories = Category.all
  end

  def show; end

  def new
    @category = Category.new
  end

  def create  
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: "Category was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: "Category was successfully updated." }
      end
        format.html { render :new, status: :unprocessable_entity }
    end
  end

  def destroy
    respond_to do |format|
      if @category.destroy
        format.html { redirect_to categories_path, notice: "Category deleted successfully!"}
      end
    end
  end

  private 

  def set_category
    @category = Category.friendly.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description, :image)
  end
end
