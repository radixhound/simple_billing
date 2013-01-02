Given /^I am not logged in$/ do
  visit root_path
  page.should have_content("log in")
end

When /^I visit the admin area$/ do
  visit admin_root_path
end

Then /^I should be required to login$/ do
  page.should have_content('You must first log in or sign up before accessing this page')
end

Then /^I should be on the Admin Dashboard page$/ do
  find("h1.main_title").should have_content('Admin Dashboard') #brittle -> what if we have a link here?
end

Given /^I am viewing a user$/ do
  step 'there is a user "Bob"'
  visit admin_root_path
  user_row_id = "#user_#{@user.id}"
  within(:css, user_row_id) do
    click_link('Show')
  end
end

Then /^I should be able to return to the dasboard$/ do
  click_link("Dashboard")
  step "I should be on the Admin Dashboard page"
end

Then /^I should be able to log out$/ do
  visit admin_root_path
  click_link("Log out")
  find("h1.main_title").should have_content("Simple Billing Home")
end


