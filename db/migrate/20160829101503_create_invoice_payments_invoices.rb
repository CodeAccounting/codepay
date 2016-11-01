class CreateInvoicePaymentsInvoices < ActiveRecord::Migration
  def change
    create_table :invoice_payments_invoices do |t|
      t.references :invoice_payment, index: true, foreign_key: true
      t.references :invoice, index: true, foreign_key: true
    end
  end
end
