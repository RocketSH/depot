Rails.application.routes.draw do
  root 'store#index'
  resources :products

  resources :carts do
    resources :line_items, only: %i[create update destroy]
  end
end
