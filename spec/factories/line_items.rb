FactoryBot.define do
  factory :line_item do
    product
    cart || order

    price { product.price }
  end
end
