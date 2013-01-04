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