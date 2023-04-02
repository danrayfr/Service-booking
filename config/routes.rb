Rails.application.routes.draw do
  resources :categories
  resources :services

  devise_for :users
  root "pages#home"
end
