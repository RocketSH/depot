require 'rails_helper'

RSpec.describe 'LineItems', type: :request do
  let(:user) { create(:user)}
  subject(:product_1) { create(:product) }
  subject(:invalid_product) do
    { 'id' => 'a', 'title' => '1', 'description' => '' }
  end
  subject(:product_2) { create(:zootopia) }
  let(:cart) { Cart.create(user_id: user.id)}

  describe 'POST /create' do
    context 'with valid product' do
      it 'creates a new line item' do
        sign_in(user)
        expect { post line_items_path(product_id: product_1), xhr: true }.to change(
          LineItem,
          :count,
        ).by(1)
      end

      it 'redirects to the homepage' do
        sign_in(user)
        post line_items_path(product_id: product_1)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_url)
      end

      it 'add duplicate products to a cart' do
        sign_in(user)
        cart
        5.times { post line_items_path(product_id: product_1) }

        expect(cart.line_items.count).to eq(1)
        expect(cart.line_items.first['quantity']).to eq(5)
      end
    end
  end

  describe 'revise quantity' do
    context 'with valid parameters' do
      it 'minus 1' do
        sign_in(user)
        line_item = create(:line_item, quantity: 5)
        post line_item_reduce_path(line_item)
        line_item.reload
        expect(line_item.quantity).to eq(4)
      end

      it 'add 1' do
        sign_in(user)
        line_item = create(:line_item, quantity: 1)
        post line_item_add_path(line_item)
        line_item.reload
        expect(line_item.quantity).to eq(2)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested line_item when qty == 1' do
      sign_in(user)
      line_item = create(:line_item, quantity: 1)
      expect { post line_item_reduce_path(line_item) }.to change(LineItem, :count).by(-1)
    end

    it 'destroys line item' do
      sign_in(user)
      line_item = create(:line_item, quantity: 5)
      expect { delete line_item_path(line_item) }.to change(LineItem, :count).by(-1)
    end
  end
end
