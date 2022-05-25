require 'rails_helper'

RSpec.describe 'LineItems', type: :request do
  subject(:valid_product) { create(:product) }
  subject(:invalid_product) do
    { 'id' => 'a', 'title' => '1', 'description' => '' }
  end
  subject(:zootopia) { create(:zootopia) }

  describe 'POST /create' do
    context 'with valid product' do
      it 'creates a new line item' do
        expect { post line_items_path(product_id: valid_product) }.to change(
          LineItem,
          :count,
        ).by(1)
      end

      it 'redirects to the homepage' do
        post line_items_path(product_id: valid_product)

        # 302 redirect: temporarily moved
        expect(response).to have_http_status(302)

        cart = Cart.last
        expect(response).to redirect_to(root_url)
      end

      it 'add duplicate products to a cart' do
        5.times { post line_items_path(product_id: zootopia) }

        zoo_cart = Cart.last
        expect(zoo_cart.line_items.count).to eq(1)
        expect(zoo_cart.line_items.first['quantity']).to eq(5)
      end
    end

    context 'with invalid/ non-exist product' do
      it 'does not create a new line item' do
        expect do
          post line_items_path(product_id: invalid_product)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'line item quantity minus 1& redirects to the cart' do
        line_item = create(:line_item, quantity: 5)
        put line_item_path(line_item)
        line_item.reload
        expect(line_item.quantity).to eq(4)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested line_item when qty == 1' do
      line_item = create(:line_item)
      expect { put line_item_path(line_item) }.to change(LineItem, :count).by(
        -1,
      )
    end
  end
end
