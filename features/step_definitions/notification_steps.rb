Then /^an invoice notification( with activation link |\s)is sent to "(.*?)"$/ do |activation, user_name|
  @email = ActionMailer::Base.deliveries.first
  @email.should be
  user = User.where(username: user_name).first
  invoice = user.invoices.first
  @email.to[0].should == user.email
  @email.body.should include(user_confirmation_url(user.signup_token)) unless activation.strip.blank?
  @email.body.should include(invoice.title)
  @email.body.should include(invoice.amount)
end

Then /^I should receive payment confirmation email$/ do
  @email = ActionMailer::Base.deliveries.first
  @email.should be
  invoice = @user.invoices.first
  @email.to[0].should == @user.email
  @email.subject.should include("Payment Confirmation")
  @email.body.should include(invoice.title)
  @email.body.should include(invoice.amount)
end