Then /^an email with activation link is sent to "(.*?)"$/ do |user_name|
  @email = ActionMailer::Base.deliveries.first
  user = User.where(username: user_name).first
  @email.to[0].should == user.email
  @email.body.should include(user_activation_url(user.signup_token))
end