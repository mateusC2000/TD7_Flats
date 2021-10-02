Rails.application.routes.draw do
  devise_for :property_owners
  root 'home#index'
  resources :properties, only: [:show, :new, :create, :edit, :update]
  resources :property_types, only: [:new, :create, :show]
  resources :property_locations, only: [:new, :create, :show]
end
