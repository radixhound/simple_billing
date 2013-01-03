Then /^I should be on my user page$/ do
  step %Q(I should be on the user page for "#{@user.username}")
end

Then /^I should be on the user page for "(.*?)"$/ do |user_name|
  find("h1.main_title").should have_content("Dashboard for #{user_name}")
end

When /^I try to visit the user page for "(.*?)"$/ do |user_name|
  visit user_path(User.where(username: user_name).first)
end

Then /^I receive a not authorized message$/ do
  find('#flash_alert').should have_content("You are not authorized to view that page.")
end