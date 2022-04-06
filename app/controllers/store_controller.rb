class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
  before_action :increment_counter
  before_action :current_line_item

  def index
    @products = Product.order(:title)
  end

  private

  def increment_counter
    @counter = session[:counter] = (session[:counter] || 0) + 1
  end

  def current_line_item
    @current_line_item ||= session[:line_item_id] && LineItem.find(session[:line_item_id])
  end
end
