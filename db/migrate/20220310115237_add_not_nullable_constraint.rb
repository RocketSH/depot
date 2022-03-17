class AddNotNullableConstraint < ActiveRecord::Migration[6.0]
  def change
    change_column_null :line_items, :cart_id, false
    change_column_null :products, :title, false
    change_column_null :products, :description, false
  end
end
