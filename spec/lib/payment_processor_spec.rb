require 'spec_helper'

describe PaymentProcessor do
  describe "#process" do
    let(:processor) { PaymentProcessor.new(invoice) }
    let(:user) { FactoryGirl.create(:user_with_card) }
    let(:invoice) { FactoryGirl.create(:invoice, user: user) }
    let(:succesful_charge) { 
      Stripe::Charge.construct_from(id: "1234", paid: true) }
    let(:unsuccesful_charge) { 
      Stripe::Charge.construct_from(id: "1234", paid: false) }

    context "when payment successful" do
      before do
        Stripe::Charge.stubs(:create).returns(succesful_charge)
      end

      it "marks the invoices as paid" do
        processor.process
        invoice.paid.should be_true
      end

      it "sends the charge to stripe" do
        Stripe::Charge.expects(:create).
          with(amount: (invoice.amount * 100).to_i,
                currency_type: 'CAD',
                customer: user.stripe_user_id,
                description: "#{invoice.id}: #{invoice.title}").
          returns(succesful_charge)
        processor.process
      end
    end

    context "when payment unsuccessful" do
      before do
        Stripe::Charge.stubs(:create).returns(unsuccesful_charge)
      end

      it "keeps the invoice as unpaid" do
        processor.process
        invoice.paid.should be_false        
      end
    end
  end
end 