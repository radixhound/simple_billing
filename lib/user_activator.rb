class UserActivator

  def initialize(signup_token, params)
    @signup_token = signup_token
    @user = User.where(signup_token: @signup_token).first
    @params = params
  end

  def activate
    @user.signup_token = nil
    @user.stripe_user_id = create_stripe_customer if @params[:stripe_card_token].present?
    @user.update_attributes(@params)
    @user
  end

  private

  def create_stripe_customer
    response = Stripe::Customer.create(
      :description => "#{@user.username}",
      :email => "#{@user.email}", 
      :card => @params.delete(:stripe_card_token) )
    response.id
  end

end