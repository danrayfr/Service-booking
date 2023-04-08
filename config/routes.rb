Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  
  # routes only accessible to users
  resources :billings
  resources :bookings
  
  # routes only accessible to admin
  authenticated :user, ->(user) { user.admin? } do
    get "dashboard", to: "dashboard#index"
    get "dashboard/bookings"
    get "dashboard/users"
    get "dashboard/services"
    get "dashboard/billings"
    get "dashboard/payments"
    get "dashboard/categories"
    get "dashboard/receipts"
    resources :categories
    resources :services
    resources :payments
  end

  devise_for :users
  root "bookings#index"
end
