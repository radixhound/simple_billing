Given /^there is an admin user "(.*?)"$/ do |admin_user_name|
  password = "some_password"
  AdminUser.create(username: admin_user_name, password: password, password_confirmation: password) 
end

Given /^there are no users in the system$/ do
  User.destroy_all
end

When /^I add "(.*?)"$/ do |user_name|
  session[:administrator_id] = Administrator.first.id
  visit admin_users
end

Then /^I should see "(.*?)" in the users list$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end