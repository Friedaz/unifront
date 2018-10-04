Rails.application.routes.draw do

  resources :orders
  resources :line_items
  resources :carts


  resources :products do
    resources :reviews, except: [:show, :index]
  end

  resources :stores

  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root 'home#index'

  get 'profil' => 'profil#index'

  resources :conversations do
    resources :messages
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
