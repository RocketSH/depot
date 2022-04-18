require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  let(:cart) { create(:cart) }
  let(:empty_cart) { FactoryBot.build(:cart) }

  describe 'GET /new' do
    context 'with not empty cart' do
      it 'should get new' do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session) {
          { cart_id: cart.id }
        }

        get new_order_url
        expect(response).to be_successful
      end
    end

    context 'with empty cart' do
      it 'requires item in cart' do
        empty_cart.save
        get new_order_url, params: { id: empty_cart[:id] }
        # binding.pry
        expect(response).to redirect_to(root_url)
        follow_redirect!
        expect(response).to render_template('store/index')
        expect(response.body).to include(
          'Your cart is empty.'
        )
      end
    end
  end
end
