Given /^there is an admin user "(.*?)"$/ do |admin_user_name|
  @user = FactoryGirl.create(:admin_user, username: admin_user_name)
end

Given /^I am logged in as an admin user$/ do
  step 'there is an admin user "admin"'
  visit new_session_path
  fill_in("login", :with => @user.username)
  fill_in("password", :with => @user.password)
  click_button("Log in")
end

Given /^there are no users in the system$/ do
  User.destroy_all
end

When /^I add "(.*?)"$/ do |user_name|
  @new_user = FactoryGirl.build(:user, username: user_name)
  visit admin_user_path
  click_button("Add User")
  fill_in("username", with: @new_user.username )
end

Then /^I should see "(.*?)" in the users list$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end