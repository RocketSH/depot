class LineItem < ApplicationRecord
  # optional: true, the association will not have its presence validated
  belongs_to :product
  belongs_to :cart, optional: true
  belongs_to :order, optional: true

  validates :product_id, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :cart_id, presence: true, if: -> { :order_id.nil? }
  validates :order_id, presence: true, if: -> { :cart_id.nil? }

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
