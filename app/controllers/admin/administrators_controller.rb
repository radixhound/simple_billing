module Admin

  class AdministratorsController < ApplicationController
    before_filter :login_required, :except => [:new, :create]

    def new
      @administrator = Administrator.new
    end

    def create
      @administrator = Administrator.new(params[:administrator])
      if @administrator.save
        session[:administrator_id] = @administrator.id
        redirect_to root_url, :notice => "Thank you for signing up! You are now logged in."
      else
        render :action => 'new'
      end
    end

    def edit
      @administrator = current_administrator
    end

    def update
      @administrator = current_administrator
      if @administrator.update_attributes(params[:administrator])
        redirect_to root_url, :notice => "Your profile has been updated."
      else
        render :action => 'edit'
      end
    end
  end

end