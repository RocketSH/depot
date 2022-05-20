require 'rails_helper'

RSpec.describe ChargeOrderJob, type: :job do
  include ActiveJob::TestHelper
  let(:order) { create(:order, :purchase_order)}
  let(:order_params) { {name: order.name, address: order.address, email: order.email, pay_type: order.pay_type} }
  let(:pay_type_params) {{"po_number"=>"123456"}}

  subject(:job) { ChargeOrderJob.perform_later(order.id, order_params[:pay_type], pay_type_params) }

  describe '#create jobs' do
    it 'queues the job' do
      expect { job }.to have_enqueued_job(ChargeOrderJob)
        .with(order.id, order_params[:pay_type], pay_type_params).on_queue("default")
    end

    it 'executes perform_later' do
      perform_enqueued_jobs { job }
    end
  
    after do
      clear_enqueued_jobs
      clear_performed_jobs
    end
  end
end
