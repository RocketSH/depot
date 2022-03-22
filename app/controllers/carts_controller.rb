class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: %i[show edit update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invaild_cart

  def show
    @cart = Cart.find(params[:id]) until @cart.id == session[:cart_id]
  end

  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    redirect_to root_url, notice: 'Your cart is currently empty.'
  end

  private

  def invaild_cart
    logger.error "Attempt to access invalid cart #{params[:id]}"
    redirect_to root_url, notice: 'Sorry, you are querying an invalid cart'
  end
end
