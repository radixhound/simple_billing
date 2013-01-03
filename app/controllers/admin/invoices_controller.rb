class Admin::InvoicesController < AdminController
  
  before_filter :get_user

  def show
    @invoice = @user.invoices.find(params[:id])
  end

  def new
    @invoice = Invoice.new
  end

  def create
    @invoice = @user.invoices.build(params[:invoice])
    if @invoice.save
      redirect_to [:admin, @user], :notice => "Successfully created invoice."
    else
      render :action => 'new'
    end
  end

  def update
    @invoice = @user.invoices.find(params[:id])
    if @invoice.update_attributes(params[:invoice])
      redirect_to [:admin, @user], :notice  => "Successfully updated invoice."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @invoice = @user.invoices.find(params[:id])
    @invoice.destroy
    redirect_to [:admin, @user], :notice => "Successfully destroyed invoice."
  end

  def edit
    @invoice = @user.invoices.find(params[:id])
  end

  private

  def get_user
    @user = User.find(params[:user_id]) || not_found
  end

end
