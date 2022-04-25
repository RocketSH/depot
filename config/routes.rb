Rails.application.routes.draw do
  root 'store#index'
  resources :products do
    get :who_bought, on: :member
  end

  resources :carts
  resources :line_items, only: %i[create update destroy]
  resources :orders
end
