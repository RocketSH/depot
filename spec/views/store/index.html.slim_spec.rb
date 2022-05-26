require 'rails_helper'

RSpec.describe 'store/index.html.slim', type: :view do
  before(:each) do
    @products = FactoryBot.build_list(:product, 3)
    assign(:product, @products)
  end

  # TODO: `Warden::Proxy`
  it 'renders a list of products', pending: true do
    expect(render).to have_selector('ul.catalog')
    assert_select 'ul.catalog li', count: 3
  end

  it 'if price range between 0.01 to 99.99' do
    @products.each do |product|
      expect(product.price.to_s).to match(/\b\d{1,2}\.\d{1,2}/)
    end
  end
end
