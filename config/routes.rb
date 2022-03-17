Rails.application.routes.draw do
  root 'store#index'
  resources :products

  resources :line_items, only: [:create]
  resources :carts
end
