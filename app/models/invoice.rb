class Invoice < ActiveRecord::Base
  attr_accessible :title, :description, :amount, :date, :paid, :charge_id

  belongs_to :user

  validates :title, :amount, :presence => true

  def state
    if payable?
      "payable"
    elsif paid?
      "paid"
    else
      "pending"
    end
  end

  def make_payable
    self.payable = true
    self.save
  end

  scope :payable, where(payable: true)

  def pending?
    !payable
  end
end