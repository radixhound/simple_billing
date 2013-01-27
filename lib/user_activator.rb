class UserActivator

  def initialize(signup_token, params)
    @signup_token = signup_token
    @user = User.where(signup_token: @signup_token).first
    @params = params
  end

  def activate
    @user.signup_token = nil
    card_token = @params.delete(:stripe_card_token)
    @user.stripe_user_id = create_stripe_customer(card_token) unless card_token.blank?
    @user.update_attributes(@params)
    @user
  end

  private

  def create_stripe_customer(card_token)
    response = Stripe::Customer.create(
      :description => "#{@user.username}",
      :email => "#{@user.email}", 
      :card => card_token )
    response.id
  rescue Stripe::CardError => e
    @user.stripe_error = e.message
  end
end