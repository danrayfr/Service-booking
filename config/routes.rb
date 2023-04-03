Rails.application.routes.draw do
  resources :bookings
  resources :payments
  resources :categories
  resources :services

  devise_for :users
  root "bookings#index"
end
