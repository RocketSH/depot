require 'sidekiq/web'

Rails.application.routes.draw do
  # check the sidekiq activity on http://localhost:3000/sidekiq
  mount Sidekiq::Web => 'sidekiq'

  root 'store#index'
  resources :products do
    get :who_bought, on: :member
  end

  resources :carts
  resources :line_items, only: %i[create update destroy]
  resources :orders
end
