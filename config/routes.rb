Rails.application.routes.draw do
  get 'cart/show'
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  
  # routes only accessible to users
  resources :billings
  resources :bookings
  get "cart", to: "cart#show"
  post "cart/add"
  post "cart/remove"
  
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

  # errors route 
  # match "/404", to: "errors#not_found", via: :all
  # match "/505", to: "errors#internal_server_error", via: :all
end
