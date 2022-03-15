require 'rails_helper'

RSpec.describe "LineItems", type: :request do
  describe "#create" do
    let(:factory_product) {create(:product)}

    it "create a line item" do
      post line_items_path(product_id: factory_product)
      # 302 redirect: temporarily moved
      expect(response).to have_http_status(302)
      # TODO: create a cart has line_item& test redirect
      # expect(response).to redirect_to(@line_item.cart)  
    end
  end
end
