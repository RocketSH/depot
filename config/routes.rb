Rails.application.routes.draw do
  devise_for :users, controllers: {
        registrations: 'users/registrations',
        sessions: 'users/sessions'
  }

  root 'store#index'
  resources :products do
    get :who_bought, on: :member
  end

  resources :carts
  resources :line_items, only: %i[create update destroy]
  resources :orders
end
