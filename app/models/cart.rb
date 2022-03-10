class Cart < ApplicationRecord
  # each line_item contains a reference to its cart_id
  #the existence of each line_item is depentent on the existence of the cart
  has_many :line_items, dependent: :destroy
end