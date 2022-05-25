require 'rails_helper'

RSpec.describe 'Carts', type: :request do
  let(:user) { create(:user)}
  let(:cart) { Cart.create(user_id: user.id)}
  let(:product_1) { create(:zootopia) }
  let(:product_2) { create(:product) }
  let(:invalid_cart) { { id: 'not_a_valid_id' } }

  before do
    cart.add_product(product_1).save!
    cart.add_product(product_2).save!
  end

  describe 'GET /show' do
    context 'with valid cart' do
      it 'renders a successful response' do
        sign_in(user)
        get cart_path(cart)
        expect(response).to be_successful
      end
    end

    context 'with invalid cart' do
      it 'the user only can retrieve their own cart' do
        sign_in(user)
        get '/carts/:id', params: { id: invalid_cart[:id] }
        expect(response).to render_template('carts/show')
        expect(cart.user_id).to eq user.id
      end
    end
  end

  describe 'DELETE / destroy' do
    context 'with valid cart' do
      it 'destroys current cart' do
        sign_in(user)
        expect(cart.line_items).not_to be_empty
        delete cart_path(cart)
        expect(Cart.find_by(id: cart.id)).to be_nil
      end

      it 'redirects to product catalog page' do
        sign_in(user)
        delete cart_url(cart)
        expect(response).to redirect_to(root_url)
      end
    end
  end
end
