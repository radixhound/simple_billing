class AdministratorSessionsController < ApplicationController
  def new
  end

  def create
    administrator = Administrator.authenticate(params[:login], params[:password])
    if administrator
      session[:administrator_id] = administrator.id
      redirect_to_target_or_default root_url, :notice => "Logged in successfully."
    else
      flash.now[:alert] = "Invalid login or password."
      render :action => 'new'
    end
  end

  def destroy
    session[:administrator_id] = nil
    redirect_to root_url, :notice => "You have been logged out."
  end
end
