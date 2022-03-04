require 'rails_helper'

RSpec.describe "Stores", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/"
      p response.body

      expect(response).to have_http_status(:success)
      assert_select ".side_nav a", minimum: 4
    end
  end
end
