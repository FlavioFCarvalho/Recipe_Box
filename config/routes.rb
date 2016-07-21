Rails.application.routes.draw do
  get 'categories/index'

  get 'categories/new'

  get 'categories/edit'

  devise_for :users
  resources :recipes
  resources :categories

  root "recipes#index"
end
