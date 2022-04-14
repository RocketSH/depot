FactoryBot.define do
  factory :cart do
    after :create do |cart|
      create_list :line_item, 2, cart: cart
    end
  end
end
