Rails.application.routes.draw do
  devise_for :users
 root to: 'home#index'

 resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy]
 resources :suppliers
 resources :product_models, only: [:index, :show, :new, :create]
 
 resources :orders, only: [:new, :create, :show, :edit, :update] do
  get 'search', on: :collection
 end
end
