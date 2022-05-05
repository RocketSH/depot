class ChargeJob
  include Sidekiq::Job

  # perform method arguments must be simple, basic types like String, integer, boolean that are supported by JSON. Complex Ruby objects will not work.

  def perform(order,pay_type_params)
    order = Order.find(order.id)
    order.charge!(pay_type_params.to_h)
  end
end
