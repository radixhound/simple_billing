class Invoice < ActiveRecord::Base
  attr_accessible :title, :description, :amount, :date
end
