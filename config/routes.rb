Rails.application.routes.draw do
  root 'home#index'
  resources :properties, only: [:show]
end
