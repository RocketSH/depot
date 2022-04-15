require 'rails_helper'

RSpec.describe 'Stores', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/'

      expect(response).to have_http_status(:success)
      assert_select '.side_nav a', minimum: 3
    end
  end

  describe 'POST /add or update a line item' do
    subject(:product) { create(:product) }
    it 'updates the quantity' do
      post line_items_path(product_id: product), xhr: true
      expect(response.body).to include('carts')
    end
  end
end