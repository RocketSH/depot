class LineItem < ApplicationRecord
  # optional: true, the association will not have its presence validated
  belongs_to :product
  belongs_to :cart, optional: true
  belongs_to :order, optional: true

  validates :cart_id, :product_id, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  def subtotal
    product.price * quantity
  end

  def minus_line_item_qty
    if self.quantity > 1
      self.quantity -= 1
      self.save
    else
      self.destroy
    end
  end
end
