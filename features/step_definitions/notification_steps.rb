Then /^an invoice notification with activation link is sent to "(.*?)"$/ do |user_name|
  @email = ActionMailer::Base.deliveries.first
  @email.should be
  user = User.where(username: user_name).first
  invoice = user.invoices.first
  @email.to[0].should == user.email
  @email.body.should include(user_activation_url(user.signup_token))
  @email.body.should include(invoice.title)
  @email.body.should include(invoice.amount)
end