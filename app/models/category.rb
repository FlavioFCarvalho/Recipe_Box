class Category < ActiveRecord::Base
	has_many :categories_recipes, class_name: 'CategoriesRecipe'
end
