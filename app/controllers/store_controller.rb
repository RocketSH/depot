class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
  before_action :increment_counter

  def index
    @products = Product.order(:title)
  end

  private

  def increment_counter
    @counter = session[:counter] = (session[:counter] || 0) + 1
  end
end
