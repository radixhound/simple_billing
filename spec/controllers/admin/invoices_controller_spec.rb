require 'spec_helper'

describe Admin::InvoicesController do
  fixtures :all
  render_views

  it "show action should render show template" do
    get :show, :id => Invoice.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Invoice.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Invoice.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(admin_invoice_url(assigns[:invoice]))
  end

  it "update action should render edit template when model is invalid" do
    Invoice.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Invoice.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    Invoice.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Invoice.first
    response.should redirect_to(admin_invoice_url(assigns[:invoice]))
  end

  it "destroy action should destroy model and redirect to index action" do
    invoice = Invoice.first
    delete :destroy, :id => invoice
    response.should redirect_to(root_url)
    Invoice.exists?(invoice.id).should be_false
  end

  it "edit action should render edit template" do
    get :edit, :id => Invoice.first
    response.should render_template(:edit)
  end
end
