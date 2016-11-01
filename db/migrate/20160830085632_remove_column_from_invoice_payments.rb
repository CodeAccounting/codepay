class RemoveColumnFromInvoicePayments < ActiveRecord::Migration
  def change
  	remove_column :invoice_payments, :invoice_id
  end
end
