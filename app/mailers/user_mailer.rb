class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(invoice)
    @invoice = invoice
    @user = @invoice.user
    if @user.pending?
      @url  = user_confirmation_url(@user.signup_token)
      mail(:to => @user.email, :subject => "Welcome to My Awesome Site")
    else
      raise "Can't send welcome email to active user"
    end
  end

  def invoice_notification(invoice)
    @invoice = invoice
    @user = @invoice.user
    @url  = user_invoice_url(@user.id, @invoice.id)
    mail(:to => @user.email, :subject => "You have a new invoice")
  end

  def payment_confirmation(invoice)
    @invoice = invoice
    @user = @invoice.user
    @url  = user_invoice_url(@user.id, @invoice.id)
    mail(:to => @user.email, :subject => "Payment Confirmation")
  end

end