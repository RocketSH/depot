FactoryBot.define do
  factory :cart do
    after :create do |cart|
      create_list :line_item, 3, cart: cart
    end
  end
end
