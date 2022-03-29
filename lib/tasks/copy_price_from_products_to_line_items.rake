desc "copy price from table products to table line_items"

task copy_price_from_products_to_line_items: :environment do
  puts 'Duplicating product price...'

  ActiveRecord::Base.connection.execute('UPDATE line_items SET price = products.price FROM products WHERE line_items.product_id = products.id AND line_items.price is null')

  puts 'Duplication done!'
end