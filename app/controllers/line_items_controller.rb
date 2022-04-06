class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: %i[create destroy]
  before_action :set_line_item, only: %i[show edit update destroy]

  def create
    product = Product.find(params[:product_id])
    line_item = @cart.add_product(product)

    if line_item.save
      reset_counter
      session[:line_item_id] = line_item.id
      redirect_to root_url
    else
      render :new
    end
  end

  def update
    if @line_item.minus_line_item_qty
      redirect_to @line_item.cart, notice: 'Product was successfully revised quantity.'
    else
      redirect_to @line_item.cart, notice: 'Sorry, this product quantity can not be revised.'
    end
  end

  # ensure that the user is deleting his or her own cart (think about it!)
  # to remove the cart from the session before redirecting to the index page with a notification message:
  def destroy
    @line_item.destroy

    redirect_to @cart, notice: 'Product was successfully removed from your shopping cart.'
  end

  private

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  def reset_counter
    session[:counter] = 0
  end

  def line_item_params
    params.require(:line_item).permit(:product_id, :cart_id, :quantity, :price)
  end
end
