Given /^there is an admin user "(.*?)"$/ do |admin_user_name|
  @administrator = FactoryGirl.create(:admin_user, username: admin_user_name)
end

Given /^I am logged in as an admin user$/ do
  step 'there is an admin user "admin"'
  visit new_session_path
  fill_in("login", :with => @administrator.username)
  fill_in("password", :with => @administrator.password)
  click_button("Log in")
end

Given /^there is a user "(.*?)"$/ do |user_name|
  @user = FactoryGirl.create(:user, username: user_name)
end

Given /^there are no users in the system$/ do
  User.destroy_all
end

When /^I add "(.*?)"$/ do |user_name|
  @new_user = FactoryGirl.build(:user, username: user_name)
  visit admin_root_path
  click_link("Add User")
  fill_in("user_username", with: @new_user.username )
  fill_in("user_email", with: @new_user.email )
  fill_in("user_password", with: @new_user.password )
  fill_in("user_password_confirmation", with: @new_user.password )
  click_button("Create User")
  # save_and_open_page
end

Then /^I should see "(.*?)" on the Admin Dashboard$/ do |user_name|
  page.should have_content(user_name)
  page.should have_content('Admin Dashboard')
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

When /^I edit "(.*?)" to have:$/ do |user_name, table|
  # table is a Cucumber::Ast::Table
  user_row_id = "#user_#{@user.id}"
  visit admin_root_path
  within(:css, user_row_id) { click_link("Edit") }
  fill_in("user_username", with: table.rows_hash['username'])
  fill_in("user_email", with: table.rows_hash['email'])
  click_button("Update User")
end