class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: %i[show destroy]
  include RescueInvalidCart
  rescue_from ActiveRecord::RecordNotFound, with: :invaild_cart

  def show
    render layout: "authentication"
  end

  def destroy
    @cart.destroy
    redirect_to '/', notice: 'Your cart is currently deleted.' 
  end
end
