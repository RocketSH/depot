#./spec/requests/sessions_spec.rb
require 'rails_helper'
RSpec.describe "Sessions" do
  it "signs user in and out" do
    user = create(:user)
    cart = Cart.create(user_id: user.id)

    sign_in user
    get orders_path
    expect(response).to render_template(:index)
    
    sign_out user
    get orders_path
    get root_path
    expect(response).not_to render_template('orders/index')
  end
end
