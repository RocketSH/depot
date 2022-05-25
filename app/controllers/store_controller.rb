class StoreController < ApplicationController
  include RescueInvalidCart
  before_action :increment_counter
  rescue_from ActiveRecord::RecordNotFound, with: :invaild_cart

  def index
    @products = Product.order(:title)
    @cart = Cart.find_by(user_id: current_user.id) if current_user
  end

  private

  def increment_counter
    @counter = session[:counter] = (session[:counter] || 0) + 1
  end
end
