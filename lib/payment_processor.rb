class PaymentProcessor

  CURRENCIES = { canadian: 'cad' }

  def initialize(invoice)
    @invoice = invoice
  end

  def process
    if charge = create_charge
      @invoice.update_attributes(paid: true, charge_id: charge.id)
      UserMailer.payment_confirmation(@invoice).deliver
    else
      false
    end
  end

  def customer_failure_message
    "Unable to process payment for #{invoice.title}. #{@reason_message}"
  end

  private

  def create_charge
    Stripe::Charge.create(
        amount: (invoice.amount * 100).to_i,
        currency: CURRENCIES[:canadian],
        customer: invoice.user.stripe_user_id,
        description: invoice_description )
    rescue Stripe::CardError => e
      @reason_message = e.message
      false
  end

  def invoice
    @invoice
  end

  def invoice_description
    "#{invoice.id}: #{invoice.title}"
  end

end