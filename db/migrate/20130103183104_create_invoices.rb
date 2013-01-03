class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.string :title
      t.text :description
      t.decimal :amount
      t.datetime :date
      t.timestamps
    end
  end

  def self.down
    drop_table :invoices
  end
end
