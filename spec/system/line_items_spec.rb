require 'rails_helper'

RSpec.describe "LineItems/ create", type: :system do
  let(:product) { create_list(:product, 2) }

  scenario "add highlight css class" do
    visit root_path(product)

    expect(page).to have_no_css('table tbody tr.line-item-highlight')
    within '.catalog' do
      click_button 'Add to Cart', match: :first
    end

    expect(page).to have_css('table tbody tr.line-item-highlight')
  end
end
