class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  validates :cart_id, :product_id, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  def subtotal
    product.price * quantity
  end
end
