class StoreController < ApplicationController
  before_action :increment_counter

  def index
    @products = Product.order(:title)
    @cart = Cart.find_by(user_id: current_user.id) if current_user
  end

  private

  def increment_counter
    @counter = session[:counter] = (session[:counter] || 0) + 1
  end
end
