class AddPendingToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :payable, :boolean, default: false
  end
end
