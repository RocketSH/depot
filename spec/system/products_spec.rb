require 'rails_helper'

RSpec.describe "Products", type: :system do
  user = FactoryBot.create(:user)
  let(:zootopia) { create(:zootopia) }

  before do
    driven_by(:rack_test)
  end

  it "Update a exist product" do
    login_as(user, scope: :user)
    visit edit_product_path(zootopia)

    fill_in "Title", with: "Shakira is the best!"
    click_button "Update Product"
    zootopia.reload

    expect(page).to have_content("Product was successfully updated.")
    click_link "Back"
  end
end
