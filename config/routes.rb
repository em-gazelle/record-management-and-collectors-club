Rails.application.routes.draw do

  root 'records_users#index'

  devise_for :users

  resources :records_users do
  	get 'explore', on: :collection
  end

  resources :records, only: [:create, :update] do
  	get 'artist_overview', on: :collection
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
