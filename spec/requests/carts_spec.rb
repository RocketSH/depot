require 'rails_helper'

RSpec.describe 'Carts', type: :request do
  # every cart has 3 line items once created from factorybot
  let(:cart) {create(:cart)}

  describe 'DELETE / destroy' do
    it 'destroys current cart' do
      expect(cart.line_items).not_to be_empty

      allow_any_instance_of(ActionDispatch::Request).to receive(:session) { { cart_id: cart.id } }
      delete cart_url(cart)

      expect(Cart.find_by(id: cart.id)).to be_nil
    end

    it 'redirects to product catalog page' do
      allow_any_instance_of(ActionDispatch::Request).to receive(:session) { { cart_id: cart.id } }
      delete cart_url(cart)
      expect(response).to redirect_to(root_url)
    end
  end
end