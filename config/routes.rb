Rails.application.routes.draw do
  resources :pages, except: [:show]
  get "/pages/:permalink" => "pages#permalink", as: :permalink

  # get 'pages/show'
  # get 'home/index'
  # get 'genres/index'
  # get 'genres/show'
  # get 'products/index'
  # get 'products/show'

  # get "search", to: "products#search", as: "search"
  root to: "home#index"
  get "products", to: "products#index"
  get "products/:id", to: "products#show", id: /\d+/, as: "product"

  get "genres", to: "genres#index"
  get "genres/:id", to: "genres#show", id: /\d+/, as: "genre"

  resources :products, only: %i[index show] do
    collection do
      get "search"
    end
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
