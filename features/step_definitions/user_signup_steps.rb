Given /^There is a pending user "(.*?)"$/ do |user_name|
  FactoryGirl.create(:pending_user, username: user_name)
end

When /^I visit the activation page for "(.*?)"$/ do |user_name|
  visit user_confirmation_path(User.where(username: user_name).first.signup_token)
end

When /^I fill in my password$/ do
  fill_in('user_password', with: 'password')
  fill_in('user_password_confirmation', with: 'password')
  click_button('Submit')
end

When /^I enter my billing information$/ do
  fill_in('card_number', with: '4242424242424242')
  fill_in('card_code', with: '122')
  select('1 - January', :from => 'card_month')
  select('2014', :from => 'card_year')
end

Then /^the user should see his card information$/ do
  within('.card_info') {
    find('.card_digits').should have_content('4242')
    find('.card_type').should have_content('Visa')
    find('.card_expiry').should have_content('1 / 2014')
  }
end

