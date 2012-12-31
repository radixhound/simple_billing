require File.dirname(__FILE__) + '/../spec_helper'

describe AdminSessionsControllersController do
  fixtures :all
  render_views

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when authentication is invalid" do
    AdminUser.stubs(:authenticate).returns(nil)
    post :create
    response.should render_template(:new)
    session['admin_user_id'].should be_nil
  end

  it "create action should redirect when authentication is valid" do
    AdminUser.stubs(:authenticate).returns(AdminUser.first)
    post :create
    response.should redirect_to(root_url)
    session['admin_user_id'].should == AdminUser.first.id
  end
end
