class HomeController < ApplicationController
  def index
    if logged_in?
      redirect_to( current_user.admin? ? admin_root_url : user_url(current_user) )
    else
      redirect_to(login_url)
    end
  end
end
