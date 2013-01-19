class InvoiceDelivery
  def initialize(invoice)
    @invoice = invoice
    @user = @invoice.user
  end

  def deliver
    if deliver_email
      @invoice.make_payable
      true
    else
      false
    end
  end

  private

  def deliver_welcome_email
    UserMailer.welcome_email(@invoice.user, @invoice).deliver
  end

  def deliver_email
    if @user.pending?
      deliver_welcome_email 
    else
      deliver_invoice_notification
    end
  end

  def deliver_invoice_notification
    true
  end
end