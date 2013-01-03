require File.dirname(__FILE__) + '/../spec_helper'

describe InvoicesController do
  fixtures :all
  render_views

  it "show action should render show template" do
    get :show, :id => Invoice.first
    response.should render_template(:show)
  end
end
