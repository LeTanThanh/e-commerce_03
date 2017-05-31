Rails.application.routes.draw do
  root "static_pages#home"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/signup",  to: "users#new"
  post "/signup",  to: "users#create"
  get "/login", to: "sessions#new"
  get "/*page", to: "static_pages#show"

  resources :users
end
