Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  devise_for :users
  devise_for :property_owners
  root 'home#index'
  get 'my_profile', to: 'users#my_profile'

  resources :properties, only: %i[show new create edit update] do
    get 'my_properties', on: :collection
    resources :property_reservations, only: %i[create show], shallow: true do
      post 'accept', on: :member
    end
  end
  resources :property_types, only: %i[new create show]
  resources :property_locations, only: %i[new create show]

  namespace :api do
    namespace :v1 do
      resources :properties, only: %i[index show]
    end
  end
end
