def login_as(user)
  visit new_session_path
  fill_in("login", :with => user.username)
  fill_in("password", :with => user.password)
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

When /^I log in as a user$/ do
  step 'I am logged in as a user'
end