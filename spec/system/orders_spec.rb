require 'rails_helper'

RSpec.describe "Orders", type: :system, js: true do
  let(:product) { create_list(:product, 2) }

  scenario "Check routing number" do
    visit root_path(product)

    click_button 'Add to Cart', match: :first
    click_button "Checkout"

    fill_in 'order_name', with: 'John Watson'
    fill_in 'order_address', with: '221B Baker Street'
    fill_in 'order_email', with: 'dr_watson@bbb.com'

    expect(page).to have_no_field('order_routing_number')
    have_selector 'order_pay_type', with_options: ['Check', 'Purchase order', 'Credit card'], selected: 'Check'
    select 'Check', from: 'order_pay_type'
    expect(page).to have_field('order_routing_number')
  end

  scenario "Render pay type Credit card component" do
    visit root_path(product)

    click_button 'Add to Cart', match: :first
    click_button "Checkout"

    fill_in 'order_name', with: 'John Watson'
    fill_in 'order_address', with: '221B Baker Street'
    fill_in 'order_email', with: 'dr_watson@bbb.com'
    expect(page).to have_no_field('order_credit_card_number')
    have_selector 'order_pay_type', with_options: ['Check', 'Purchase order', 'Credit card']
    select 'Credit card', from: 'order_pay_type'
    expect(page).to have_field('order_credit_card_number')
  end

  scenario "Render pay type Purchase order component" do
    visit root_path(product)

    click_button 'Add to Cart', match: :first
    click_button "Checkout"

    fill_in 'order_name', with: 'John Watson'
    fill_in 'order_address', with: '221B Baker Street'
    fill_in 'order_email', with: 'dr_watson@bbb.com'
    expect(page).to have_no_field('order_po_number')
    have_selector 'order_pay_type', with_options: ['Check', 'Purchase order', 'Credit card']
    select 'Purchase order', from: 'order_pay_type'
    expect(page).to have_field('order_po_number')
  end
end
