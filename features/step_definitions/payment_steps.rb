Given /^I have a valid card$/ do
  card_token = get_card_token(:valid)
  activate_user(@user, card_token)
end

Given /^I have an card that will be declined$/ do
  card_token = get_card_token(:declined)
  activate_user(@user, card_token)
end

When /^I make a payment$/ do
  click_link('Pay Now')
  find('h1.main_title').should have_content("Confirm Payment")
  click_link('Yes')
end

Then /^the invoice for "(.*?)" should be marked as paid$/ do |title|
  find('h1.main_title').should have_content("Dashboard for #{@user.username}")
  for_invoice(title) { find('.paid').should have_content("Yes") }
end

When /^I do not confirm payment$/ do
  click_link('Pay Now')
  find('h1.main_title').should have_content("Confirm Payment")
  click_link('No')
end

Then /^the invoice for "(.*?)" should not be marked as paid$/ do |title|
  find('h1.main_title').should have_content("Invoice for #{title}")
  page.has_css?('.paid')
end

When /^I make an invalid payment$/ do
  PaymentProcessor.any_instance.stubs(:process => false)
  step 'I make a payment'
end

Then /^I should see "(.*?)"$/ do |message|
  page.should have_content(message)
end

def get_card_token(card_type)
  card_number = case card_type
    when :declined then '4000000000000341'
    when :invalid  then '4242424242424241'
    when :valid    then '4242424242424242'
    end
  response = Stripe::Token.create(
    card: { number: card_number,
          cvc: '123',
          exp_month: 12,
          exp_year:  2016 }
  )
  response.id
end

def activate_user(user, card_token)
  @user.create_signup_token
  @user.save
  UserActivator.new(
      @user.signup_token, 
      stripe_card_token: card_token
    ).activate
end