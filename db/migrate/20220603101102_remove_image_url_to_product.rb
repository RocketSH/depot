class RemoveImageUrlToProduct < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :image_url
    change_column_null :products, :image_data, true
  end
end
