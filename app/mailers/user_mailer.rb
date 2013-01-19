class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(user, invoice = nil)
    @user = user
    @invoice = invoice if invoice
    if @user.pending?
      @url  = user_activation_url(user.signup_token)
      mail(:to => user.email, :subject => "Welcome to My Awesome Site")
    end
  end
end