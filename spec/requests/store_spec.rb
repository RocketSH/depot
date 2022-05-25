require 'rails_helper'

RSpec.describe 'Stores', type: :request do
  describe 'GET /index' do
    let(:products) { create_list(:product, 5)}
    
    it 'returns http success' do
      get root_path(products)
      
      expect(response).to have_http_status(:success)
      assert_select '.side_nav a', minimum: 3
    end
  end
end