require 'rails_helper'

RSpec.describe ChargeOrderJob, type: :job do
  let(:order) { Order.new(id: 1, name: 'John Watson', address: '221B Baker Street', email: 'dr_watson@bbb.com', pay_type: 'Credit card')}
  let(:cart) { create(:cart)}
# , order_credit_card_number: 4024007193015467, order_expiration_date: '3/2022'
  it "invoke payment API in the background" do
    post orders_path(order)
    # expect { post line_items_path(product_id: valid_product) }.to change(
    #   LineItem,
    #   :count,
    # ).by(1)
    
  end
  
end
