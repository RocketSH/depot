require 'rails_helper'

RSpec.describe 'LineItems', type: :request do
  describe '#create' do
    let(:factory_product) { create(:product) }

    it 'create a new line item' do
      post line_items_path(product_id: factory_product)

      # 302 redirect: temporarily moved
      expect(response).to have_http_status(302)
      cart = Cart.last
      expect(response).to redirect_to(cart)

      item = cart.line_items
      expect(item.select(:product_id)) == (factory_product.id)
    end
  end
end
