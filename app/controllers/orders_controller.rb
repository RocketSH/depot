class OrdersController < ApplicationController
  before_action :set_cart, only: %i[new create]
  before_action :ensure_cart_isnt_empty, only: :new
  before_action :set_order, only: %i[show edit update destroy]

  def create
  end

  def new
  end

  private

  def set_cart
    if session[:cart_id]
      @cart = Cart.find(session[:cart_id])
    else
      redirect_to root_url, notice: "Your cart is empty."
    end
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def ensure_cart_isnt_empty
    if @cart.line_items.empty?
      redirect_to root_url, notice: "Your cart is empty."
    end
  end
end
