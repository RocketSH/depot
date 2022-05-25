class ChargeOrderJob < ApplicationJob
  queue_as :default

  def perform(order_id, pay_type, pay_type_params)
    Order.find_by(id: order_id).charge!(pay_type, pay_type_params.to_h, order_id)
  end
end
