class InvoicesController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @invoice = @user.invoices.find(params[:id])
  end
end
