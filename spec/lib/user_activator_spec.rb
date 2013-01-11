require 'spec_helper'

describe UserActivator do

  let(:user) { FactoryGirl.create(:pending_user) }
  let(:user_params) { { password: '123456', password_confirmation: '123456',
                   stripe_card_token: "tok_sometoken",
                   stripe_card_type: "Visa", stripe_card_digits: "4242",
                   stripe_card_expiry: "01 / 2013"} }
  let(:signup_token) { user.signup_token }
  let(:stripe_user) { Stripe::Customer.new("usr_1234567") }

  describe "#activate" do
    subject { UserActivator.new(signup_token, user_params).activate }

    before do
      Stripe::Customer.stubs(create: stripe_user)
    end

    it {should be_an_instance_of(User)}

    its(:signup_token) { should be_blank }
    its(:password) { should_not be_blank }
    its(:stripe_user_id) { should_not be_blank }

    it 'creates user on stripe' do
      Stripe::Customer.expects(:create).with( 
        description: user.username, 
        email: user.email, 
        card: user_params[:stripe_card_token]).returns(stripe_user)
      subject
    end

    context "when no card data is provided" do
      let(:user_params) { { password: '123456', password_confirmation: '123456'} }

      it 'should not try to create the stripe user' do
        UserActivator.any_instance.expects(:create_stripe_customer).never
        Stripe::Customer.expects(:create).never
        subject
      end
    end

  end



end