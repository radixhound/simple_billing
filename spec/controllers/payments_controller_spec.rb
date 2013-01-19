require 'spec_helper'

describe PaymentsController do
  fixtures :all
  render_views

  let(:user) { FactoryGirl.create(:stripe_activated_user) }
  let(:invoice) { FactoryGirl.create(:invoice, user: user) }

  describe "#new" do
    it "renders new template" do
      get :new, user_id: user.id, invoice_id: invoice.id
      response.should render_template(:new)
    end
  end

  describe "#confirm" do
    context "when payment is valid" do
      it "redirects to user page" do
        put :confirm, user_id: user.id, invoice_id: invoice.id
        response.should redirect_to(user_path(user))
      end
    end

    context "when payment is not valid" do
      before do
        PaymentProcessor.any_instance.stubs(process: false)
      end

      it "redirects to invoice page" do
        put :confirm, user_id: user.id, invoice_id: invoice.id
        response.should redirect_to(user_invoice_path(user, invoice))
      end
    end
  end
end
