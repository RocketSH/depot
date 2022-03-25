FactoryBot.define do
  factory :line_item do
    product
    cart

    price { product.price }
  end
end
