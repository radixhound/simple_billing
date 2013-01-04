require 'spec_helper'

describe Admin::AdminsController do
  fixtures :all
  render_views

  let(:admin_user) { FactoryGirl.create(:admin_user) }

  it "index action should render index template" do
    session[:user_id] = admin_user.id
    get :index
    response.should render_template(:index)
  end
end