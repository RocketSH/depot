class StoreController < ApplicationController
  before_action :increment_counter
  before_action :current_line_item

  def index
    @products = Product.order(:title)
    @cart = Cart.find(session[:cart_id]) if session[:cart_id]
  end

  private

  def increment_counter
    @counter = session[:counter] = (session[:counter] || 0) + 1
  end

  def current_line_item
    if session[:line_item_id]
      @current_line_item ||= session[:line_item_id] && LineItem.find(session[:line_item_id])
    end
  end
end
