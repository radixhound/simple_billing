class UserObserver < ActiveRecord::Observer

  def after_create(user)
    unless user.admin?
      UserMailer.welcome_email(user).deliver
    end
  end
end
