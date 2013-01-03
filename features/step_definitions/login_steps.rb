def login_as(user, password = nil)
  visit new_session_path
  fill_in("login", :with => user.username)
  fill_in("password", :with => password || user.password)
  click_button("Log in")
end

Given /^I am logged in as an admin user$/ do
  step 'there is an admin user "admin"'
  login_as(@administrator)
end

When /^I log in as an admin user$/ do
  step 'I am logged in as an admin user'
end

Given /^I am logged in as a user$/ do
  step 'there is a user "Bob"'
  login_as(@user)
end

Given /^I am logged in as a user "(.*?)"$/ do |user_name|
  step %Q(there is a user "#{user_name}")
  login_as(@user)
end

When /^I log in as a user$/ do
  step 'I am logged in as a user'
end

Given /^I log in as a user "(.*?)"$/ do |user_name|
  user = User.where(username: user_name).first
  login_as(user, 'password')
end