When /^I make a payment$/ do
  click_link('Pay Now')
  find('h1.main_title').should have_content("Confirm Payment")
  click_link('Yes')
end

Then /^the invoice for "(.*?)" should be marked as paid$/ do |title|
  find('h1.main_title').should have_content("Dashboard for #{@user.username}")
  for_invoice(title) { find('.paid').should have_content("Yes") }
end

When /^I do not confirm payment$/ do
  click_link('Pay Now')
  find('h1.main_title').should have_content("Confirm Payment")
  click_link('No')
end

Then /^the invoice for "(.*?)" should not be marked as paid$/ do |title|
  find('h1.main_title').should have_content("Invoice for #{title}")
  page.has_css?('.paid')
end