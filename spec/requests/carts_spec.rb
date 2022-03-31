require 'rails_helper'

RSpec.describe 'Carts', type: :request do
  # every cart has 3 line items once created from factorybot
  let(:cart) { create(:cart) }
  let(:invalid_cart_test) { { id: 'not_a_valid_id' } }

  describe 'GET /show' do
    context 'with valid cart' do
      it 'renders a successful response' do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session) {
          { cart_id: cart.id }
        }

        get cart_path(cart)
        expect(response).to be_successful
      end
    end

    context 'with invalid cart' do
      it 'rescue ActiveRecord::RecordNotFound' do
        get '/carts/:id', params: { id: invalid_cart_test[:id] }
        expect(response).to redirect_to(root_url)
        follow_redirect!
        expect(response).to render_template('store/index')
        expect(response.body).to include(
          'Sorry, you are querying an invalid cart'
        )
      end
    end
  end

  describe 'DELETE / destroy' do
    context 'with valid cart' do
      it 'destroys current cart' do
        expect(cart.line_items).not_to be_empty
        allow_any_instance_of(ActionDispatch::Request).to receive(:session) {
          { cart_id: cart.id }
        }
        delete cart_url(cart)
        expect(Cart.find_by(id: cart.id)).to be_nil
      end

      it 'redirects to product catalog page' do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session) {
          { cart_id: cart.id }
        }
        delete cart_url(cart)
        expect(response).to redirect_to(root_url)
      end
    end

    # TODO: to be refactored, since the mock session always pass with an invalid cart id
    context 'with invalid cart' do
      it 'destroys an invalid cart' do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session) {
          { cart_id: invalid_cart_test[:id] }
        }
        delete cart_url(invalid_cart_test)
        expect(response).to redirect_to(cart_url)
      end
    end
  end
end
