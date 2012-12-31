class AdminUsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create]

  def new
    @admin_user = AdminUser.new
  end

  def create
    @admin_user = AdminUser.new(params[:admin_user])
    if @admin_user.save
      session[:admin_user_id] = @admin_user.id
      redirect_to root_url, :notice => "Thank you for signing up! You are now logged in."
    else
      render :action => 'new'
    end
  end

  def edit
    @admin_user = current_admin_user
  end

  def update
    @admin_user = current_admin_user
    if @admin_user.update_attributes(params[:admin_user])
      redirect_to root_url, :notice => "Your profile has been updated."
    else
      render :action => 'edit'
    end
  end
end
