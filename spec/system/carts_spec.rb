require 'rails_helper'

RSpec.describe "LineItems/ create", type: :system do
  user = FactoryBot.create(:user)
  let(:product) { create(:zootopia) }
  let(:cart) { create(:cart) }

  scenario "add a cart" do
    login_as(user, scope: :user)
    visit root_path(product)

    expect(page).to have_no_css('.carts')
    expect(page).to have_no_table

    within '.catalog' do
      click_button 'Add to Cart', match: :first
    end

    expect(page).to have_css('.carts')
    expect(page).to have_css('table tbody tr td.quantity')
    expect(page).to have_css('table tbody tr td.price')
    expect(page).to have_content('Total amount: 50 z')
    expect(page).to have_button('Checkout')
    expect(page).to have_button('Empty cart')
  end

  scenario "LineItems/ destroy" do
    login_as(user, scope: :user)
    visit root_path(product)

    expect(page).to have_no_css('.carts')
    expect(page).to have_no_table

    within '.catalog' do
      click_button 'Add to Cart', match: :first
    end
    
    expect(page).to have_css('.carts')
    expect(page).to have_content('Total amount: 50 z')

    accept_alert do
      within '.side_nav' do
        click_button 'Empty cart'
      end
    end

    expect(page).to have_no_css('.carts')
    expect(page).to have_no_table
    expect(page).to have_no_content('Total amount: 50 z')
  end
end
