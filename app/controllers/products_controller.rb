class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy who_bought]

  def index
    @products = Product.all.order(:title)
  end

  def new
    @product = Product.new
  end

  def show
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to product_url(@product),
                  notice: 'Product was successfully created.'
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      redirect_to product_url(@product),
                  notice: 'Product was successfully updated.'

      @products = Product.all.order(:title)
      ActionCable.server.broadcast 'products', html: render_to_string('store/index', layout: false)
    else
      render @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
  end

  def who_bought
    @latest_order = @product.orders.order(:updated_at).last

    if stale?(@latest_order)
      respond_to do |format|
        format.html { render template: 'products/who_bought' }
        format.atom
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:title, :description, :image_url, :price)
  end
end
