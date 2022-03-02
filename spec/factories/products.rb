FactoryBot.define do
  # make some random products
  factory :product do
      title { Faker::Books::Dune.title }
      description { Faker::Books::Dune.quote }
      image_url { Faker::Avatar.image + ".jpg" }
      price { Faker::Number.between(from: 0.49, to: 999) }
  end

  # or specify a product
  factory :zootopia, class: Product do
    title { "Try Everything" }
    description { "Oh, oh, oh, oh, oh
    Oh, oh, oh, oh, oh
    Oh, oh, oh, oh, oh
    Oh, oh, oh, oh, oh
    I messed up tonight
    I lost another fight
    Lost to myself, but I'll just start again" }
    image_url { "https://insidethemagic.net/wp-content/uploads/2016/12/zootopia1.jpg" }
    price { rand(1..50000) }
  end
end