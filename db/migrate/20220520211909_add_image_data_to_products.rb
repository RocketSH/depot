class AddImageDataToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :image_data, :jsonb
  end
end
