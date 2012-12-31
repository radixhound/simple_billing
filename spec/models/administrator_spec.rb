require File.dirname(__FILE__) + '/../spec_helper'

describe Administrator do
  def new_administrator(attributes = {})
    attributes[:username] ||= 'foo'
    attributes[:email] ||= 'foo@example.com'
    attributes[:password] ||= 'abc123'
    attributes[:password_confirmation] ||= attributes[:password]
    Administrator.new(attributes)
  end

  before(:each) do
    Administrator.delete_all
  end

  it "should be valid" do
    new_administrator.should be_valid
  end

  it "should require username" do
    new_administrator(:username => '').should have(1).error_on(:username)
  end

  it "should require password" do
    new_administrator(:password => '').should have(1).error_on(:password)
  end

  it "should require well formed email" do
    new_administrator(:email => 'foo@bar@example.com').should have(1).error_on(:email)
  end

  it "should validate uniqueness of email" do
    new_administrator(:email => 'bar@example.com').save!
    new_administrator(:email => 'bar@example.com').should have(1).error_on(:email)
  end

  it "should validate uniqueness of username" do
    new_administrator(:username => 'uniquename').save!
    new_administrator(:username => 'uniquename').should have(1).error_on(:username)
  end

  it "should not allow odd characters in username" do
    new_administrator(:username => 'odd ^&(@)').should have(1).error_on(:username)
  end

  it "should validate password is longer than 3 characters" do
    new_administrator(:password => 'bad').should have(1).error_on(:password)
  end

  it "should require matching password confirmation" do
    new_administrator(:password_confirmation => 'nonmatching').should have(1).error_on(:password)
  end

  it "should generate password hash and salt on create" do
    administrator = new_administrator
    administrator.save!
    administrator.password_hash.should_not be_nil
    administrator.password_salt.should_not be_nil
  end

  it "should authenticate by username" do
    administrator = new_administrator(:username => 'foobar', :password => 'secret')
    administrator.save!
    Administrator.authenticate('foobar', 'secret').should == administrator
  end

  it "should authenticate by email" do
    administrator = new_administrator(:email => 'foo@bar.com', :password => 'secret')
    administrator.save!
    Administrator.authenticate('foo@bar.com', 'secret').should == administrator
  end

  it "should not authenticate bad username" do
    Administrator.authenticate('nonexisting', 'secret').should be_nil
  end

  it "should not authenticate bad password" do
    new_administrator(:username => 'foobar', :password => 'secret').save!
    Administrator.authenticate('foobar', 'badpassword').should be_nil
  end
end
