class RecipesController < ApplicationController
	before_action :find_recipe, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]
	
	def index
		@recipes = Recipe.all.page params[:page]
		respond_to do |format|
      format.js
      format.html
    end
	end

	def show
		@comments = Comment.where(recipe_id: @recipe) 
	end

	def new
		@recipe = current_user.recipes.build
	end

	def create
		@recipe = current_user.recipes.build(recipe_params)

		if @recipe.save
			redirect_to @recipe, notice: "Successfully created new recipe"
		else
			render 'new'
		end
	end

	def edit
		
	end

	def update
		if @recipe.update(recipe_params)
			redirect_to @recipe
		else
			render 'edit'
		end
	end

	def destroy
		@recipe.destroy
		redirect_to root_path, notice: "Successfully deleted recipe"
	end

	private

	def recipe_params
		params.require(:recipe).permit(:title, :description, :image,
			ingredients_attributes: [:id, :name, :_destroy],
			directions_attributes: [:id, :step, :_destroy],
		  recipe_categories_attributes: [:category_id,:recipe_id , :_destroy])
	end

	def find_recipe
		@recipe = Recipe.find(params[:id])
	end
end
