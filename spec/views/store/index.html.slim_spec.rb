require 'rails_helper'

RSpec.describe 'store/index.html.slim', type: :view do
  # before(:each) do
  #   @products = FactoryBot.build_list(:product, 3)
  #   assign(:product, @products)
  # end
  let(:user) { create(:user) }
  let(:products) { create_list(:product, 3)}

  it 'if price range between 0.01 to 99.99' do
    products.each do |product|
      expect(product.price.to_s).to match(/\b\d{1,2}\.\d{1,2}/)
    end
  end
end
