class CategoriesController < ApplicationController
  
  def index
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category, notice: "Successfully created new category"
    else
      render 'new'
    end
  end  

  def edit
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end
