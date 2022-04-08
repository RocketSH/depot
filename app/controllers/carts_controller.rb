class CartsController < ApplicationController
  include CurrentCart
  include CurrentLineItem
  before_action :set_current_line_item, only: :show
  before_action :set_cart, only: %i[edit update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invaild_cart

  def show
    @cart = Cart.find(session[:cart_id])
  end

  def destroy
    if @cart.id != nil && @cart.id == session[:cart_id]
      @cart.destroy
      session[:cart_id] = nil
      session[:line_item_id] = nil
      redirect_to '/', notice: 'Your cart is currently deleted.'
    else
      redirect_to cart_url, notice: 'Sorry, this cart not found for deletion.'
    end
  end

  private

  def invaild_cart
    logger.error "Attempt to access invalid cart #{params[:id]}"
    redirect_to root_url, notice: 'Sorry, you are querying an invalid cart'
  end
end
