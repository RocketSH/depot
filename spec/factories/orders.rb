FactoryBot.define do
  factory :order do
    name { Faker::Name.name }
    address { Faker::Address.full_address }
    email { Faker::Internet.email }
    pay_type { ['Check', 'Credit card', 'Purchase order'].sample }
  end
end
