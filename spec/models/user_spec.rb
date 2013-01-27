require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user, 
    username: 'foobar',
    email: 'foo@bar.com',
    password: 'secret',
    password_confirmation: 'secret')}

  describe '#has_card?' do
    subject { user }

    context "when user has card" do
      let(:user) { FactoryGirl.create(:user_with_card)}

      its(:has_card?) { should be_true }
    end

    context "when user has no card" do

      its(:has_card?) { should be_false }
    end
  end

  it "should generate password hash and salt on create" do
    user.password_hash.should_not be_nil
    user.password_salt.should_not be_nil
  end

  it "should authenticate by username" do
    user.save!
    User.authenticate('foobar', 'secret').should == user
  end

  it "should authenticate by email" do
    user.save!
    User.authenticate('foo@bar.com', 'secret').should == user
  end

  it "should not authenticate bad username" do
    User.authenticate('nonexisting', 'secret').should be_nil
  end

  context "when invalid password" do
    let(:user) { FactoryGirl.create(:user, :username => 'foobar', :password => 'secret') }

    it "should not authenticate" do
      User.authenticate('foobar', 'badpassword').should be_nil
    end
  end

  context "with stripe_errors" do
    before do
      user.stripe_error = "Invalid card sucker"
    end
    its(:valid?) { should be_false }

    it "has the right error" do 
      user.save
      user.errors.messages[:base].should include('Invalid card sucker')
    end
  end
end
