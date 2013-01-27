require 'spec_helper'

describe '/payments/new.html.haml' do

  let(:last_four) { '4297' }
  let(:user) { FactoryGirl.create(:user, stripe_card_digits: last_four, stripe_card_expiry: "1 / 2013", stripe_card_type: "Visa") }
  let(:invoice) { FactoryGirl.create(:invoice, user: user) }

  before do
    assign(:user, user)
    assign(:invoice, invoice)
    render
  end

  let(:page) { Capybara.string(rendered) }

  it "has the yes option" do
    page.should have_content('Yes')
  end

  it "has the invoice amount" do
    page.should have_content(number_to_currency(invoice.amount))
  end

  it "has the invoice title" do
    page.should have_content(invoice.title)
  end

  it "has credit card information" do
    page.should have_content("**** **** **** #{last_four}")
    page.should have_content("Visa")
    page.should have_content("1 / 2013")
  end
end
