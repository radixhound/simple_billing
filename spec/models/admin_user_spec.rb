require File.dirname(__FILE__) + '/../spec_helper'

describe AdminUser do
  def new_admin_user(attributes = {})
    attributes[:username] ||= 'foo'
    attributes[:email] ||= 'foo@example.com'
    attributes[:password] ||= 'abc123'
    attributes[:password_confirmation] ||= attributes[:password]
    AdminUser.new(attributes)
  end

  before(:each) do
    AdminUser.delete_all
  end

  it "should be valid" do
    new_admin_user.should be_valid
  end

  it "should require username" do
    new_admin_user(:username => '').should have(1).error_on(:username)
  end

  it "should require password" do
    new_admin_user(:password => '').should have(1).error_on(:password)
  end

  it "should require well formed email" do
    new_admin_user(:email => 'foo@bar@example.com').should have(1).error_on(:email)
  end

  it "should validate uniqueness of email" do
    new_admin_user(:email => 'bar@example.com').save!
    new_admin_user(:email => 'bar@example.com').should have(1).error_on(:email)
  end

  it "should validate uniqueness of username" do
    new_admin_user(:username => 'uniquename').save!
    new_admin_user(:username => 'uniquename').should have(1).error_on(:username)
  end

  it "should not allow odd characters in username" do
    new_admin_user(:username => 'odd ^&(@)').should have(1).error_on(:username)
  end

  it "should validate password is longer than 3 characters" do
    new_admin_user(:password => 'bad').should have(1).error_on(:password)
  end

  it "should require matching password confirmation" do
    new_admin_user(:password_confirmation => 'nonmatching').should have(1).error_on(:password)
  end

  it "should generate password hash and salt on create" do
    admin_user = new_admin_user
    admin_user.save!
    admin_user.password_hash.should_not be_nil
    admin_user.password_salt.should_not be_nil
  end

  it "should authenticate by username" do
    admin_user = new_admin_user(:username => 'foobar', :password => 'secret')
    admin_user.save!
    AdminUser.authenticate('foobar', 'secret').should == admin_user
  end

  it "should authenticate by email" do
    admin_user = new_admin_user(:email => 'foo@bar.com', :password => 'secret')
    admin_user.save!
    AdminUser.authenticate('foo@bar.com', 'secret').should == admin_user
  end

  it "should not authenticate bad username" do
    AdminUser.authenticate('nonexisting', 'secret').should be_nil
  end

  it "should not authenticate bad password" do
    new_admin_user(:username => 'foobar', :password => 'secret').save!
    AdminUser.authenticate('foobar', 'badpassword').should be_nil
  end
end
