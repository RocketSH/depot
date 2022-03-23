class AddNotNullableToLineItems < ActiveRecord::Migration[6.0]
  def change
    change_column_null :products, :price, false
    execute 'UPDATE line_items SET price = products.price FROM products WHERE line_items.product_id = products.id AND line_items.price is null'

    change_column_null :line_items, :price, false
  end
end
