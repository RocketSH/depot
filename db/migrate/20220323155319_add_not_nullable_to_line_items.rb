class AddNotNullableToLineItems < ActiveRecord::Migration[6.0]
  def change
    change_column_null :products, :price, false
    change_column_null :line_items, :price, false
  end
end
