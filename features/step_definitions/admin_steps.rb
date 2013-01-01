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
  visit admin_users_path
  click_link("Add User")
  fill_in("user_username", with: @new_user.username )
  fill_in("user_email", with: @new_user.email )
  fill_in("user_password", with: @new_user.password )
  fill_in("user_password_confirmation", with: @new_user.password )
  click_button("Create User")
end

Then /^I should see "(.*?)" in the users list$/ do |user_name|
  page.has_content?(user_name)
end