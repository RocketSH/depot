class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: %i[destroy]
  include RescueInvalidCart
  rescue_from ActiveRecord::RecordNotFound, with: :invaild_cart

  def show
    @cart = Cart.includes(line_items: :product).find(session[:cart_id])
  end

  def destroy
    respond_to do |format|
      if @cart && @cart.id == session[:cart_id]
        @cart.destroy
        session[:cart_id] = nil
        format.html { redirect_to '/', notice: 'Your cart is currently deleted.' }
        format.js
      else
        format.html { redirect_to cart_url, notice: 'Sorry, this cart not found for deletion.' }
      end
    end
  end

end
