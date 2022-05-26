require 'sendgrid-ruby'

class OrderMailer < ApplicationMailer
  include SendGrid

  def received(order)
    @order = order
    mail(from: 'Świat Zabawek <shu-han@llinformatics.com>' ,to: @order.email, subject: 'Świat Zabawek Store Order Confirmation')
  end

  def shipped(order)
    @order = order
    mail(from: 'Świat Zabawek <shu-han@llinformatics.com>' ,to: @order.email, subject: 'Świat Zabawek Store Order Shipped')
  end
end