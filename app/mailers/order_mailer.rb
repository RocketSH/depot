class OrderMailer < ApplicationMailer
  require 'sendgrid-ruby'
  include SendGrid

  def received(order)
    @order = order
    mail(from: 'Świat Zabawek <shu-han@llinformatics.com>' ,to: @order.email, subject: 'Świat Zabawek Store Order Confirmation')

    unless Rails.env.development? 
      sg = SendGrid::API.new(api_key: Rails.application.credentials.sendgrid[:api_key])
      response = sg.client.mail._('send').post(request_body: mail.to_json)
      puts "=======status code========"
      puts response.status_code
      puts "=======headers========"
      puts response.headers
      puts "=======body========"
      puts response.body
    end
  end

  def shipped(order)
    @order = order

    mail to: order.email, subject: 'Świat Zabawek Store Order Shipped'
  end
end