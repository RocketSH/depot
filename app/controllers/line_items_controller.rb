class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  def create
    product = Product.find(params[:product_id])
    # build() will return an object in hash format which not yet been saved 
    @line_item = @cart.line_items.build
    @line_item.product = product

    if @line_item.save
      redirect_to @line_item.cart, notice: 'Product was successfully added into your shopping cart.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def destroy
    @line_item.destroy

    redirect_to @cart, notice: "Product was successfully removed from your shopping cart." 
  end

  private
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end
end
