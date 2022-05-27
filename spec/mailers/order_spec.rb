require "rails_helper"

RSpec.describe OrderMailer, type: :mailer do
  let(:user) { create(:user)}
  let(:order) { Order.create(name: "Buzz Lightyear", address: "Pixar Animation Studios", email: "buzz@pixar.com", user_id: user.id, pay_type: "Credit card")}

  describe "received" do
    let(:mail) { OrderMailer.received(order).deliver_now }

    it 'send a order confirmation email' do
      expect{ mail }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it "renders the headers" do
      expect(mail.subject).to eq("Świat Zabawek Store Order Confirmation")
      expect(mail.to).to eq([order.email])
      expect(mail.from).to eq([Rails.application.credentials.sendgrid[:email]])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Thank you for your recent order from The Swiat Zabawek Store.")
    end
  end

  describe "shipped" do
    let(:mail) { OrderMailer.shipped(order) }

    it "renders the headers" do
      expect(mail.subject).to eq("Świat Zabawek Store Order Shipped")
      expect(mail.to).to eq([order.email])
      expect(mail.from).to eq([Rails.application.credentials.sendgrid[:email]])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("This is just to let you know that we've shipped your recent order:")
    end
  end

end
