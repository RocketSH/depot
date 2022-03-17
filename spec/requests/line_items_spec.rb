require 'rails_helper'

RSpec.describe 'LineItems', type: :request do
  let(:valid_product) { create(:product) }
  let(:invalid_product) { { 'id' => 'a', 'title' => '1', 'description' => '' } }

  describe 'POST /create' do
    context 'with valid product' do
      it 'creates a new line item' do
        expect { post line_items_path(product_id: valid_product) }.to change(
          LineItem,
          :count
        ).by(1)
      end

      it 'redirects to the cart show' do
        post line_items_path(product_id: valid_product)

        # 302 redirect: temporarily moved
        expect(response).to have_http_status(302)

        cart = Cart.last
        expect(response).to redirect_to(cart)
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
    subject(:line_item) { create(:line_item) }
    subject(:valid_attribute) { { 'quantity' => '10' } }

    context 'with valid parameters' do
      it 'updates the requested line item attribute' do
        patch line_item_path(line_item), params: { line_item: valid_attribute }
        line_item.reload

        expect(line_item.quantity).to eq(10)
      end

      it 'redirects to the cart' do
        patch line_item_path(line_item), params: { line_item: valid_attribute }
        line_item.reload

        expect(response).to redirect_to(line_item.cart)
      end
    end

    # TODO: context 'with invalid parameters'
  end

  describe 'DELETE /destroy', pending: true do
  end
end
