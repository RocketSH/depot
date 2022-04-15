require 'rails_helper'

RSpec.describe 'carts/show.html.slim', type: :view do
  before(:each) do
    @cart = FactoryBot.create(:cart)
    assign(:cart, @cart)
  end
  subject { @cart.line_items }

  it 'renders a table of line items' do
    expect(subject.count).to eq 2
    cart_id = @cart[:id]
    item_id_first = subject.first[:id]
    item_qty_first = subject.first[:quantity]
    item_id_second = subject.last[:id]
    item_qty_second = subject.last[:quantity]
    total_amount = subject.first[:price] + subject.last[:price]

    expect(render).to have_selector('h2')
    expect(render).to match(/Your Current Cart ID:#{cart_id}/)
    expect(render).to match(/#{item_id_first}/)
    expect(render).to match(/#{item_id_second}/)
    expect(render).to match(/#{item_qty_first}/)
    expect(render).to match(/#{item_qty_second}/)
    expect(render).to have_selector('table')
    expect(render).to match(/#{total_amount}/)
  end
end
