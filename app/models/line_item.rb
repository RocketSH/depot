class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  validates :cart_id, :product_id, presence: true
end
