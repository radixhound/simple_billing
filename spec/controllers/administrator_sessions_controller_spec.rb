require File.dirname(__FILE__) + '/../spec_helper'

describe AdministratorSessionsController do
  fixtures :all
  render_views

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "sets the user session to nil"

  it "create action should render new template when authentication is invalid" do
    Administrator.stubs(:authenticate).returns(nil)
    post :create
    response.should render_template(:new)
    session['administrator_id'].should be_nil
  end

  it "create action should redirect when authentication is valid" do
    Administrator.stubs(:authenticate).returns(Administrator.first)
    post :create
    response.should redirect_to(root_url)
    session['administrator_id'].should == Administrator.first.id
  end
end
