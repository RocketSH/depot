require 'rails_helper'

RSpec.describe "LineItems/ create", type: :system do
  let(:products) { create_list(:product, 2) }
  let(:user) { create(:user)}

  scenario "add highlight css class" do
    visit root_path(products)

    login_as(user, :scope => :user)
    within '.catalog' do
      click_button 'Add to Cart', match: :first
    end

    expect(page).to have_css('table tbody tr.line-item-highlight')
  end

  describe 'can not create a new line item' do
    scenario 'without sign in' do
      visit root_path(products)
      within '.catalog' do
        click_button 'Add to Cart', match: :first
      end
      expect(page).to have_content("Please login before adding products to your cart.")
    end
  end
end
