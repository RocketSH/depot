FactoryBot.define do
  factory :order do
    name { Faker::Name.name }
    address { Faker::Address.full_address }
    email { Faker::Internet.email }

    trait :check do
      pay_type { 'Check' }
    end

    trait :credit_card do
      pay_type { 'Credit card' }
    end

    trait :purchase_order do
      pay_type { 'Purchase order' }
    end
  end
end
