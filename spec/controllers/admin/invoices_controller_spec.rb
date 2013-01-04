require 'spec_helper'

describe Admin::InvoicesController do
  fixtures :all
  render_views

  let(:invoice) { FactoryGirl.create(:invoice, user: user) }
  let(:user) { FactoryGirl.create(:user) }
  let(:request_params) { { id: invoice.id, user_id: user.id } }

  let(:admin_user) { FactoryGirl.create(:admin_user) }

  before do
    session[:user_id] = admin_user.id
  end

  it "show action should render show template" do
    get :show, request_params
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new, user_id: user.id
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Invoice.any_instance.stubs(:valid?).returns(false)
    post :create, user_id: user.id
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Invoice.any_instance.stubs(:valid?).returns(true)
    post :create, user_id: user.id
    response.should redirect_to(admin_user_path(user))
  end

  it "update action should render edit template when model is invalid" do
    Invoice.any_instance.stubs(:update_attributes).returns(false)
    put :update, request_params
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    Invoice.any_instance.stubs(:valid?).returns(true)
    put :update, request_params
    response.should redirect_to(admin_user_path(user))
  end

  it "destroy action should destroy model and redirect to index action" do
    delete :destroy, request_params
    response.should redirect_to(admin_user_path(user))
    Invoice.exists?(invoice.id).should be_false
  end

  it "edit action should render edit template" do
    get :edit, request_params
    response.should render_template(:edit)
  end
end
