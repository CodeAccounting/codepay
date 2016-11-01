class AddCustomerIdToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :customer_id, :integer
    add_column :bills, :customer_id, :integer
  end
end
