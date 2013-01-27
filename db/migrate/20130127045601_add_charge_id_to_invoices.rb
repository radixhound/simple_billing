class AddChargeIdToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :charge_id, :string
  end
end
