require 'sidekiq/web'

Rails.application.routes.draw do
  if Rails.env.test?
    require 'ostruct'
    presign_endpoint = Shrine.presign_endpoint(:cache, lambda do |id, _opts, req|
      OpenStruct.new(url: "#{req.base_url}/attachments", key: "cache/#{id}")
    end)
    mount presign_endpoint => 'presign'
    mount AttachmentUploader.upload_endpoint(:cache) => '/attachments'
  else
    mount Shrine.presign_endpoint(:cache) => 'presign/s3/params'
    mount Shrine.presign_endpoint(:cache) => 'presign'
  end

  match '*all', controller: 'application', action: 'cors_preflight_check', via: [:options]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
        registrations: 'users/registrations',
        sessions: 'users/sessions'
  }
  # check the sidekiq activity on http://localhost:3000/sidekiq
  mount Sidekiq::Web => 'sidekiq'

  mount Shrine.presign_endpoint(:cache) => "/s3/params"

  root 'store#index'
  resources :products do
    get :who_bought, on: :member
  end

  post 'carts', to: 'carts#create'
  get 'carts/:id', to: 'carts#show', as: 'cart'
  delete 'carts/:id', to: 'carts#destroy'

  # update line item qty
  post 'line_items/:id/add', to: "line_items#add_quantity", as: "line_item_add"
  post 'line_items/:id/reduce', to: "line_items#reduce_quantity", as: "line_item_reduce"

  post 'line_items', to: "line_items#create"
  get 'line_items/:id', to: "line_items#show", as: "line_item"
  delete 'line_items/:id', to: "line_items#destroy"

  resources :orders
end
