require 'rails_helper'

RSpec.describe ChargeJob, type: :system do
  let(:product) { create_list(:product, 2) }
  subject(:job) { click_button("Place Order") }

  describe "#perform_later" do
    before do
      driven_by(:selenium_chrome_headless)
      ActiveJob::Base.queue_adapter = :test
    end

    it "submit checkout form with pay_type: check" do
      visit root_path(product)

      expect(Order.count).to eq 0
      click_button 'Add to Cart', match: :first
      click_button "Checkout"

      fill_in 'order_name', with: 'John Watson'
      fill_in 'order_address', with: '221B Baker Street'
      fill_in 'order_email', with: 'dr_watson@bbb.com'
      expect(page).to have_no_field('order_routing_number')

      have_selector 'order_pay_type', with_options: ['Check', 'Purchase order', 'Credit card'], selected: 'Check'
      select 'Check', from: 'order_pay_type'
      expect(page).to have_field('order_routing_number')
      fill_in "Routing #", with: "123456"
      fill_in "Account #", with: "987654"
      
      expect { job }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
      expect(ActiveJob::Base.new.queue_name).to eq("default")
      expect(Order.count).to eq 1
    end
  end
end
