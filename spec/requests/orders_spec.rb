require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  let(:user) { create(:user)}
  let(:cart) { Cart.create(user_id: user.id) }
  let(:empty_cart) { FactoryBot.build(:cart) }
  let(:order) { build(:order, :purchase_order) }

  describe 'GET /new' do
    context 'with not empty cart' do
      it 'should get new' do
        sign_in(user)
        get new_order_path
      end
    end

    context 'with empty cart' do
      it 'requires item in cart' do
        sign_in(user)
        empty_cart.save
        expect(empty_cart.line_items).to be_empty
        get new_order_url, params: { id: empty_cart[:id] }

        expect(response).to redirect_to(root_url)
        follow_redirect!
        expect(response).to render_template('store/index')
        expect(response.body).to include('Your cart is empty.')
      end
    end
  end

  describe 'POST /create' do
    context 'with valid order' do
      it 'creates a order' do
        sign_in(user)
        # TODO: to be fixed
        # expect do
          post orders_path(order),
            params: {
              order: {
                name: order.name,
                address: order.address,
                email: order.email,
                pay_type: order.pay_type,
              }
            }.merge(user_id: user.id)
        # end.to change(Order, :count).by(1)
      end

      it 'redirects to the homepage' do
        sign_in(user)
        post orders_path(order)

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_url)
      end
    end
  end
end
