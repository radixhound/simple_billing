When /^I add a \$(\d+\.\d+) invoice for "(.*?)"$/ do |amount, title|
  click_link("Add Invoice")
  fill_in("invoice_title", with: title)
  fill_in("invoice_amount", with: amount)
  click_button("Create Invoice")
end

Given /^there is a \$(\d+\.\d+) invoice "(.*?)" for "(.*?)"$/ do |amount, title, user_name|
  user = User.where(username: user_name).first
  user.invoices.create( title: title, amount: amount, 
                        description: 'bleh', date: Date.now)
end

Then /^I should see "(.*?)" for \$(\d+\.\d+)$/ do |title, amount|
  pending # express the regexp above with the code you wish you had
end

Then /^I should not see "(.*?)" for \$(\d+\.\d+)$/ do |title, amount|
  pending # express the regexp above with the code you wish you had
end

Then /^I should be on the admin user page for "(.*?)"$/ do |user_name|
  find("h1.main_title").should have_content("Admin for #{user_name}")
end

When /^I destroy the invoice for "(.*?)"$/ do |title|
  pending # express the regexp above with the code you wish you had
end