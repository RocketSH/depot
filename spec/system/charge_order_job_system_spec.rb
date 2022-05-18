require 'rails_helper'

RSpec.describe ChargeOrderJob, type: :system do
  let(:cart) { create(:cart) }
  let(:product) { create(:zootopia) }
  let(:order) { Order.create(id: 20, name: 'John Watson', address: '221B Baker Street', email: 'dr_watson@bbb.com', pay_type: 'Purchase order' ) }
  subject(:charge_order_job) { ChargeOrderJob.perform_later(20, "Purchase order", {"po_number"=>"123456"}) }

  describe "#perform_later" do
    before do
      driven_by(:rack_test)
      # driven_by(:selenium_chrome_headless)
      ActiveJob::Base.queue_adapter = :test
    end

    it "test" do
      expect(ActiveJob::Base.queue_adapter.enqueued_jobs.count).to eq 0
      post orders_path(cart), params: {
        order: {
          name: order.name,
          address: order.address,
          email: order.email,
          pay_type: order.pay_type
        }
      }
      charge_order_job
      # expect{ charge_order_job }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
      expect(ActiveJob::Base.new.queue_name).to eq("default")
      expect{ charge_order_job }.to have_enqueued_job
      # expect(charge_order_job).to have_been_performed.with()
    end

    it "processing charge job" do

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

      click_button ''
       
      # expect { job }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
      # expect(ActiveJob::Base.new.queue_name).to eq("default")
      # expect(Order.count).to eq 1
      click_button("Place Order") 
      order = Order.last
      expect(charge_order_job).to have_enqueued_job
      expect(charge_order_job).to have_been_performed.with()
      

    end
  end
end
