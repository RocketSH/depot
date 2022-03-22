require 'rails_helper'

RSpec.describe 'carts/show.html.slim', type: :view do
  before(:each) do
    @cart = FactoryBot.create(:cart)
    assign(:cart, @cart)
  end

  it 'renders a table of line items' do
    expect(render).to have_selector('h2')
    expect(render).to have_selector('table')
    expect(render).to match(/Total amount:/)
  end
end
