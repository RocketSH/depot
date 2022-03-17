class AssociateLineItemsWithCarts < ActiveRecord::Migration[6.0]
  def change
    add_reference :line_items, :cart, foreign_key: true
  end
end
