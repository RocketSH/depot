class StoreController < ApplicationController
  def index
    # get the list of products out of the database, order by alphabetical
    @products = Product.order(:title)
  end
end
