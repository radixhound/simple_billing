class PaymentProcessor

  CURRENCIES = { canadian: 'cad' }

  def initialize(invoice)
    @invoice = invoice
  end

  def process
    begin
      Stripe::Charge.create(
        amount: (invoice.amount * 100).to_i,
        currency: CURRENCIES[:canadian],
        customer: invoice.user.stripe_user_id,
        description: invoice_description )

      @invoice.update_attribute(:paid, true)
    rescue Stripe::CardError => e
      @reason_message = e.message
      false
    end
  end

  def customer_failure_message
    "Unable to process payment for #{invoice.title}. #{@reason_message}"
  end

  private

  def invoice
    @invoice
  end

  def invoice_description
    "#{invoice.id}: #{invoice.title}"
  end

end