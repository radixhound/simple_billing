require 'spec_helper'

describe InvoicesController do
  fixtures :all
  render_views

  let(:invoice) { FactoryGirl.create(:invoice) }
  let(:user) { invoice.user }

  it "show action should render show template" do
    get :show, :id => invoice.id, :user_id => user.id
    response.should render_template(:show)
  end
end
