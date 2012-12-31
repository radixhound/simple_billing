require File.dirname(__FILE__) + '/../spec_helper'

describe Admin::AdministratorsController do
  fixtures :all
  render_views

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Administrator.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Administrator.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(root_url)
    session['administrator_id'].should == assigns['administrator'].id
  end

  it "edit action should redirect when not logged in" do
    get :edit, :id => "ignored"
    response.should redirect_to(login_url)
  end

  it "edit action should render edit template" do
    @controller.stubs(:current_administrator).returns(Administrator.first)
    debugger
    get :edit, :id => "ignored"
    response.should render_template(:edit)
  end

  it "update action should redirect when not logged in" do
    put :update, :id => "ignored"
    response.should redirect_to(login_url)
  end

  it "update action should render edit template when administrator is invalid" do
    @controller.stubs(:current_administrator).returns(Administrator.first)
    Administrator.any_instance.stubs(:valid?).returns(false)
    put :update, :id => "ignored"
    response.should render_template(:edit)
  end

  it "update action should redirect when administrator is valid" do
    @controller.stubs(:current_administrator).returns(Administrator.first)
    Administrator.any_instance.stubs(:valid?).returns(true)
    put :update, :id => "ignored"
    response.should redirect_to(root_url)
  end
end
