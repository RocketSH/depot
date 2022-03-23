class Cart < ApplicationRecord
  # the existence of each line_item is depentent on the existence of the cart
  has_many :line_items, dependent: :destroy

  def add_product(product)
    current_item = line_items.find_by(product_id: product.id)

    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product.id)
    end

    current_item
  end

  def amount
    # leave calculate work to db instead of rails
    line_items.joins(:product).sum('products.price * line_items.quantity')
  end
end
