Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  resources :billings
  resources :bookings
  resources :payments
  resources :categories
  resources :services

  devise_for :users
  root "bookings#index"
end
