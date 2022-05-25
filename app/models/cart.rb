class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :user, optional: true

  def add_product(product)
    current_item = line_items.find_by(product_id: product.id)

    if current_item
      current_item.quantity += 1
    else
      # save will be executed in line_items#create
      current_item = line_items.build(product_id: product.id, price: product.price)
    end

    current_item
  end

  def amount
    # leave calculate work to db instead of rails
    line_items.joins(:product).sum('products.price * line_items.quantity')
  end
end
