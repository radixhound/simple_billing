class PaymentProcessor

  CURRENCIES = { canadian: 'cad' }

  def initialize(invoice)
    @invoice = invoice
  end

  def process
    charge = Stripe::Charge.create(
      amount: (invoice.amount * 100).to_i,
      currency: CURRENCIES[:canadian],
      customer: invoice.user.stripe_user_id,
      description: invoice_description )
    if charge.paid
      @invoice.update_attribute(:paid, true)
    end
  end

  def customer_failure_message
    "Unable to process payment for #{invoice.title}."
  end

  private

  def invoice
    @invoice
  end

  def invoice_description
    "#{invoice.id}: #{invoice.title}"
  end

end