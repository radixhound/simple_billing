class Invoice < ActiveRecord::Base
  attr_accessible :title, :description, :amount, :date, :paid

  belongs_to :user

  validates :title, :amount, :presence => true
end