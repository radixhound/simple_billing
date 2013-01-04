require 'spec_helper'

describe Admin::UsersController do
  fixtures :all
  render_views

  let(:admin_user) { FactoryGirl.create(:admin_user) }

  before do
    session[:user_id] = admin_user.id
  end

  describe "#show" do
    it "renders show template" do
      get :show, :id => User.first
      response.should render_template(:show)
    end
  end

  describe "#new" do
    it "renders new template" do
      get :new
      response.should render_template(:new)
    end
  end

  describe '#create' do
    it "renders new template when model is invalid" do
      User.any_instance.stubs(:valid?).returns(false)
      post :create
      response.should render_template(:new)
    end

    it "redirects when model is valid" do
      User.any_instance.stubs(:valid?).returns(true)
      post :create
      response.should redirect_to(admin_root_url)
    end
  end

  describe '#edit' do
    it "edit action should render edit template" do
      get :edit, :id => User.first
      response.should render_template(:edit)
    end
  end

  describe '#update' do
    it "renders edit template when model is invalid" do
      User.any_instance.stubs(:valid?).returns(false)
      put :update, :id => User.first
      response.should render_template(:edit)
    end

    it "redirects when model is valid" do
      User.any_instance.stubs(:valid?).returns(true)
      put :update, :id => User.first
      response.should redirect_to(admin_root_url)
    end
  end

  describe '#destroy' do
    it "destroys model and redirect to index action" do
      user = User.first
      delete :destroy, :id => user
      response.should redirect_to(admin_root_url)
      User.exists?(user.id).should be_false
    end
  end
end
