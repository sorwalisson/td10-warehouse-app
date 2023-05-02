Rails.application.routes.draw do
  devise_for :users
 root to: 'home#index'

 resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy]
 resources :suppliers, only: [:new, :create, :show, :edit, :update, :index, :destroy]
 resources :product_models, only: [:index, :show, :new, :create]
 
 resources :orders, only: [:new, :create, :show, :edit, :update, :index] do
  resources :order_items, only: [:new, :create]
  get 'search', on: :collection
  post 'delivered', on: :member
  post 'canceled', on: :member
 end
end
