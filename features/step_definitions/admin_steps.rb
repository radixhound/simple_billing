Given /^there is an admin user "(.*?)"$/ do |admin_user_name|
  @administrator = FactoryGirl.create(:admin_user, username: admin_user_name)
end

Given /^there is a user "(.*?)"$/ do |user_name|
  @user = FactoryGirl.create(:user, username: user_name)
end

Given /^there are no users in the system$/ do
  User.clients.destroy_all
end

When /^I add "(.*?)"$/ do |user_name|
  @new_user = FactoryGirl.build(:user, username: user_name)
  visit admin_root_path
  click_link("Add User")
  fill_in("user_username", with: @new_user.username )
  fill_in("user_email", with: @new_user.email )
  # fill_in("user_password", with: @new_user.password )
  # fill_in("user_password_confirmation", with: @new_user.password )
  click_button("Create User")
  # save_and_open_page
end

Then /^I should see "(.*?)" on the Admin Dashboard$/ do |user_name|
  page.should have_content(user_name)
  page.should have_content('Admin Dashboard')
end

Then /^"(.*?)" has a signup token$/ do |user_name|
  user = User.where(username: user_name).first
  user.signup_token.should be
end

When /^I destroy "(.*?)"$/ do |user_name|
  user_row_id = "#user_#{@user.id}"
  visit admin_root_path
  within(:css, user_row_id){ click_link("Destroy") }
end

Then /^I should not see "(.*?)" on the Admin Dashboard$/ do |user_name|
  page.should_not have_content(user_name)
  page.should have_content('Admin Dashboard')
end

When /^I edit the user "(.*?)" to have:$/ do |user_name, table|
  # table is a Cucumber::Ast::Table
  user_row_id = "#user_#{@user.id}"
  visit admin_root_path
  within(:css, user_row_id) { click_link("Edit") }
  fill_in("user_username", with: table.rows_hash['username'])
  fill_in("user_email", with: table.rows_hash['email'])
  click_button("Update User")
end

Given /^I am on the Admin Dashboard$/ do
  visit admin_root_path
end

Then /^I should not be able to destroy myself$/ do
  user_row_id = "#user_#{@administrator.id}"
  find(user_row_id).should_not have_content("Destroy")
end