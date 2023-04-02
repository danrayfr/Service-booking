Rails.application.routes.draw do

  resources :services

  devise_for :users
  root "pages#home"
end
