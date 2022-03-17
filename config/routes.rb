Rails.application.routes.draw do
  root 'store#index'
  resources :products

  resources :line_items, only: %i[create update destroy]
  resources :carts
end
