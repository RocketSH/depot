class CombineItemsInCart < ActiveRecord::Migration[6.0]
  def change
    Cart.all.each do |cart|
      line_items_combination_and_sum_by_product_id = cart.line_items.group(:product_id).sum(:quantity)

      line_items_combination_and_sum_by_product_id.each do |product_id, quantity|
        next unless quantity > 1  
          cart.line_items.where(product_id: product_id).delete_all  

          line_item = cart.line_items.build(product_id: product_id, quantity: quantity)
          line_item.save!
      end
    end
  end
end