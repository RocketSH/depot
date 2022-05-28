require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  let(:user) { create(:user)}
  let(:order) { Order.new(name: "Buzz Lightyear", address: "Pixar Animation Studios", email: "buzz@pixar.com", user_id: user.id, pay_type: "Credit card")}
  let(:cart) { Cart.create(user_id: user.id) }
  let(:empty_cart) { FactoryBot.build(:cart) }

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
        cart
        expect(Order.count).to eq 0
        expect(Cart.count).to eq 1
        expect do
          post "/orders",
            params: {
              order: {
                name: order.name,
                address: order.address,
                email: order.email,
                pay_type: order.pay_type,
              }.merge(user_id: user.id)
            }
        end.to change(Order, :count).by(1)
        expect(Cart.count).to eq 0
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
