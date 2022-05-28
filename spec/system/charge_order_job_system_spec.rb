require 'rails_helper'

RSpec.describe ChargeOrderJob, type: :system do
  user = FactoryBot.create(:user)
  let(:product) { create_list(:product, 2) }

  describe "#perform_later" do
    before do
      driven_by(:selenium_chrome_headless)
      ActiveJob::Base.queue_adapter = :test
    end

    it "submit checkout form with pay_type: check" do
      login_as(user, scope: :user)
      visit root_path(product)

      expect(Order.count).to eq 0
      expect(ActiveJob::Base.queue_adapter.enqueued_jobs.count).to eq 0
      click_button 'Add to Cart', match: :first
      click_button "Checkout"

      fill_in 'order_name', with: 'John Watson'
      fill_in 'order_address', with: '221B Baker Street'
      fill_in 'order_email', with: 'dr_watson@bbb.com'

      have_selector 'order_pay_type', with_options: ['Check', 'Purchase order', 'Credit card']
      select 'Purchase order', from: 'order_pay_type'
      fill_in 'order_po_number', with: '123456'
      
      expect{ click_button("Place Order") }.to have_enqueued_job
      expect(ActiveJob::Base.new.queue_name).to eq("default")
      expect(Order.count).to eq 1
    end
  end
end
