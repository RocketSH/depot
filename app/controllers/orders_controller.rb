class OrdersController < ApplicationController
  before_action :set_cart, only: %i[new create]
  before_action :ensure_cart_isnt_empty, only: :new
  before_action :set_order, only: %i[show edit update destroy]

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to order_url(@order), notice: 'Your order was successfully created.'
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    if @order.update(order_params)
      redirect_to order_url(@order),
                  notice: 'Your order was successfully updated.'
    else
      render @order.errors, status: :unprocessable_entity
      render :new
    end
  end

  def destroy
    @order.destroy
    redirect_to root_url
  end

  private

  def set_cart
    if session[:cart_id]
      @cart = Cart.find(session[:cart_id])
    else
      redirect_to root_url, notice: 'Your cart is empty.'
    end
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def ensure_cart_isnt_empty
    if @cart.line_items.empty?
      redirect_to root_url, notice: 'Your cart is empty.'
    end
  end

  def order_params
    params.require(:order).permit(:name, :address, :email, :pay_type)
  end
end
