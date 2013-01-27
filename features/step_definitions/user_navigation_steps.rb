When /^I click the back button$/ do
  click_link("Back")
end

When /^I visit the homepage$/ do
  visit(root_url)
end

Then /^I should be on the login page$/ do
  find("h1.main_title").should have_content("Log in")
end