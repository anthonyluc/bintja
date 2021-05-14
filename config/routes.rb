Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/underground', as: 'rails_admin'
  # Redirection routes utilisateurs  
  devise_for :users, :controllers => { :registrations => :registrations, :passwords => :passwords }

  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  require 'sidekiq/cron/web'
  authenticate :user, ->(user) { user.admin? && user.admin_level == 1} do
    mount Sidekiq::Web => '/sidekiq'
    mount Blazer::Engine, at: "blazer"
  end
  
  root to: 'pages#home'
 
  get 'cgu', to: 'pages#cgu'
  get 'privacy_policy', to: 'pages#privacy_policy'
  get 'cookie_consent', to: 'pages#cookie_consent'
  get 'follow', to: 'followers#index'
  get 'my_cookbook', to: 'recipes#my_cookbook'
  get 'shopping_list', to: 'quantities#shopping_list'
  put 'shopping_list', to: 'shopping_lists#update'
  put 'update_quantity', to: 'quantities#update'
  delete 'avatar', to: 'users#destroy_avatar'
  
  resources :users, only: [:show] do
    post '/recipes/:recipe_id/get_recipe', to: 'users#get_recipe', as: 'get_recipe'
    post '/follow', to: 'followers#follow'
    resources :recipes, only: [:show], to: 'users#user_recipe_show'
  end

  resources :recipes, only: [:index, :create, :destroy]
  resources :recipes, only: [:update] do
    post 'recipe_group', to: 'recipes#recipe_group'
  end
  resources :recipes, only: [:show] do
    resources :quantities, only: [:destroy]
  end
  resources :reviews, only: [:create, :destroy]
  resources :recipe_rates, only: [:create]
  resources :ingredients, only: [:index, :show, :create]
  resources :quantities, only: [:update]
  resources :recipe_groups, only: [:create, :destroy, :update]
  resources :social_networks, only: [:update]

  
end
