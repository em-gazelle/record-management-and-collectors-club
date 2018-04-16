Rails.application.routes.draw do

  root 'records_users#index'

  resources :records_users
  devise_for :users
  resources :records, only: [:create, :update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
