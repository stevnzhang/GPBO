Rails.application.routes.draw do
  # API routing
  scope module: 'api', defaults: {format: 'json'} do
    namespace :v1 do
      # Only need two routes for the API
      get 'orders', to: 'orders#index'
      get 'customers/:id', to: 'customers#show'
    end
  end

  # Semi-static page routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy
  # get 'home/search', to: 'home#search', as: :search
  get 'search', to: 'search#search', as: :search

  # Authentication routes
  get 'login', to: 'sessions#new', as: :login
  get 'logout', to: 'sessions#destroy', as: :logout
  
  resources :sessions, :only => [:new, :create, :destroy]
  resources :customers, :except => [:destroy]
  resources :addresses
  resources :categories, :except => [:show, :destroy]
  resources :items
  resources :orders
  resources :users, :except => [:show, :destroy]

  patch 'items/:id/toggle_active', to: 'items#toggle_active', as: :toggle_active
  patch 'items/:id/toggle_feature', to: 'items#toggle_feature', as: :toggle_feature
  get 'place_order', to: 'orders#create', as: :place_order

  get 'item_prices/new', to: 'item_prices#new', as: :new_item_price
  post 'item_prices/create', to: 'item_prices#create', as: :item_prices

  # URL, Method, Path
  get 'cart/view_cart', to: 'cart#show', as: :view_cart
  get 'cart/:id/add_item', to: 'cart#add_item', as: :add_item
  get 'cart/:id/remove_item', to: 'cart#remove_item', as: :remove_item
  get 'cart/empty_cart', to: 'cart#empty_cart', as: :empty_cart
  get 'cart/checkout', to: 'cart#checkout', as: :checkout

  root 'home#index'
end
