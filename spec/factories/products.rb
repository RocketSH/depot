FactoryBot.define do
  sequence :product_title do |n|
    "Product #{n}"
  end

  # make some random products
  factory :product do
    title { generate(:product_title) }
    description { Faker::Books::Dune.quote }
    image_url { Faker::Avatar.image + '.jpg' }
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
    image_url do
      'https://insidethemagic.net/wp-content/uploads/2016/12/zootopia1.jpg'
    end
    price { 50 }
  end
end
