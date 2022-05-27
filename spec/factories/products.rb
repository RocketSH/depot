FactoryBot.define do
  sequence :product_title do |n|
    "Product #{n}"
  end

  # make some random products
  factory :product do
    title { generate(:product_title) }
    description { Faker::Books::Dune.quote }
    image_data { TestData.image_data }
    price { Faker::Number.between(from: 0.01, to: 99).round(2) }
  end

  # or specify a single product
  factory :zootopia, class: Product do
    title { 'Try Everything' }
    description do
      "Oh, oh, oh, oh, oh
    Oh, oh, oh, oh, oh
    Oh, oh, oh, oh, oh
    Oh, oh, oh, oh, oh
    I messed up tonight
    I lost another fight
    Lost to myself, but I'll just start again"
    end
    image_data { TestData.image_data }
    price { 50 }
  end
end
