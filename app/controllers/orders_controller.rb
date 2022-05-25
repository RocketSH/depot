class OrdersController < ApplicationController
  before_action :set_cart, only: %i[new create]
  before_action :ensure_cart_isnt_empty, only: :new
  before_action :set_order, only: %i[edit update destroy]

  def show
    @products = Order.includes(line_items: :product).find(params[:id])
  end

  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params.merge(user_id: current_user.id))
    @order.add_line_items_from_cart(@cart)

    if @order.save
      Cart.destroy(@cart.id)
      ChargeOrderJob.perform_later(@order.id, order_params[:pay_type], pay_type_params)
      redirect_to root_url, notice: 'Thank you for your order.'
    else
      render :new
    end
  end

  def edit
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
    if current_user.cart
      @cart = Cart.find_by(user_id: current_user.id)
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

  def pay_type_params
    case order_params[:pay_type]
    when "Credit card"
      params.require(:order).permit(:credit_card_number, :expiration_date)
    when "Check"
      params.require(:order).permit(:routing_number, :account_number)
    when "Purchase order"
      params.require(:order).permit(:po_number)
    else
      {}
    end
  end

end
