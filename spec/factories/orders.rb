FactoryBot.define do
  factory :order do
    name { Faker::Name.name }
    address { Faker::Address.full_address }
    email { Faker::Internet.email }
    pay_type { ['Check', 'Credit card', 'Purchase order'].sample }

    trait :checked do
      pay_type { :checked }
    end

    trait :paid_by_credit_card do
      pay_type { :paid_by_credit_card }
    end

    trait :purchased_order do
      pay_type { :purchased_order }
    end
  end
end
