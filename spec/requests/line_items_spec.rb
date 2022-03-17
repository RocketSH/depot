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
    context 'with valid parameters' do
      subject(:line_item) { create(:line_item) }
      let(:new_attributes) { { 'quantity' => '10' } }

      it 'updates the requested line item attribute' do
        patch line_item_path(line_item), params: { line_item: new_attributes }
        line_item.reload

        expect(line_item.quantity).to eq(10)
      end
    end
  end
end
