Rails.application.routes.draw do
  devise_for :users
  devise_for :property_owners
  root 'home#index'
  get 'my_profile', to: 'users#my_profile'

  resources :properties, only: %i[show new create edit update] do
    get 'my_properties', on: :collection
    resources :property_reservations, only: %i[create show], shallow: true
  end
  resources :property_types, only: %i[new create show]
  resources :property_locations, only: %i[new create show]
end
