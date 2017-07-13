Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static#index"
  resources :games, only: [:show, :create, :update, :new]
  resources :pieces, only: [:update]
end
