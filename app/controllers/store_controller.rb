class StoreController < ApplicationController
  before_action :increment_counter

  def index
    @products = Product.order(:title)
    @cart = Cart.find(session[:cart_id]) if session[:cart_id]
  end

  private

  def increment_counter
    @counter = session[:counter] = (session[:counter] || 0) + 1
  end
end
