class AdminSessionsController < ApplicationController
  def new
  end

  def create
    admin_user = AdminUser.authenticate(params[:login], params[:password])
    if admin_user
      session[:admin_user_id] = admin_user.id
      redirect_to_target_or_default root_url, :notice => "Logged in successfully."
    else
      flash.now[:alert] = "Invalid login or password."
      render :action => 'new'
    end
  end

  def destroy
    session[:admin_user_id] = nil
    redirect_to root_url, :notice => "You have been logged out."
  end
end
