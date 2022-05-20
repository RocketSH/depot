require "rails_helper"

RSpec.describe OrderMailer, type: :mailer do
  let(:order) { create(:order, :credit_card) }

  describe "received" do
    let(:mail) { OrderMailer.received(order).deliver_now }

    it 'send a order confirmation email' do
      expect{ mail }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it "renders the headers" do
      expect(mail.subject).to eq("Świat Zabawek Store Order Confirmation")
      expect(mail.to).to eq([order.email])
      expect(mail.from).to eq(["shu-han@llinformatics.com"])
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
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("This is just to let you know that we've shipped your recent order:")
    end
  end

end
