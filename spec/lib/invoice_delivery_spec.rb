require 'spec_helper'

describe InvoiceDelivery do 

  describe "#deliver" do
    let(:invoice) { FactoryGirl.create(:invoice, user: user) }
    let(:deliver) { InvoiceDelivery.new(invoice).deliver } 
    let(:welcome_email) { Object.new }
    subject { deliver }

    context "when the user is pending" do
      let(:user) { FactoryGirl.create(:pending_user) }

      it "sets the invoice to payable" do
        deliver
        invoice.reload
        invoice.should be_payable
      end

      it "sends a welcome email" do
        UserMailer.expects(:welcome_email).
          with(invoice.user, invoice).
          returns(welcome_email)
        welcome_email.expects(:deliver).returns(true)
        deliver
      end
    end

    context "when the user is active" do
      let(:user) { FactoryGirl.create(:user) }

      it "sends an invoice notification" do
        # FIXME: don't stub the object under test
        InvoiceDelivery.any_instance.expects(:deliver_invoice_notification)
        deliver
      end
    end
  end
  
end