class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create, :activate, :confirm]
  
  before_filter :current_user_only, :only => [:show]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Thank you for signing up! You are now logged in."
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to @user, :notice => "Your profile has been updated."
    else
      render :action => 'edit'
    end
  end

  def confirm
    @user = User.where(signup_token: params[:signup_token]).first
  end

  def activate
    if signup_token = params[:signup_token]
      @user = User.where(signup_token: signup_token).first
      @user.signup_token = nil
      if @user.update_attributes(params[:user])
        session[:user_id] = @user.id
        redirect_to @user, :notice => "Signup successful."
      else
        render :action => 'confirm'
      end
    else
      not_found
    end
  end
end