Given /^there are no users in the system$/ do
  User.destroy_all
end

When /^I add "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see "(.*?)" in the users list$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end