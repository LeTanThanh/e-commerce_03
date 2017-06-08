Rails.application.routes.draw do
  root "static_pages#home"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/signup",  to: "users#new"
  post "/signup",  to: "users#create"
  get "/login", to: "sessions#new"
  get "/admin/requests", to: "admin/requests#index", as: :admin_requests
  post "admin/requests/:id", to: "admin/requests#update", as: :admin_update_request
  patch "users/:id/edit", to: "users#update", as: :update_user
  get "/cart", to: "cart#show", as: :show_products_in_cart
  get "/order_details/show", to: "order_details#show",
    as: :get_product_status
  resources :users
  resources :requests
  resources :products
  resources :comments
  resources :ratings
  namespace :admin do
    resources :requests
  end
  get "/*page", to: "static_pages#show"
end
