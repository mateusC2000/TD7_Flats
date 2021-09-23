Rails.application.routes.draw do
  root 'home#index'
  resources :properties, only: [:show, :new, :create]
  resources :property_types, only: [:new, :create, :show]
end
