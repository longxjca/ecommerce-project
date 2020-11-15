Rails.application.routes.draw do
  get 'home/index'
  get 'genres/index'
  get 'genres/show'
  get 'products/index'
  get 'products/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
