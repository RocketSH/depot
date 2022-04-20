FactoryBot.define do
  factory :order do
    after :create do |order|
      create_list :order, order: order
    end
  end
end
