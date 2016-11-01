class AddCcAndBccToInvoiceEmails < ActiveRecord::Migration
  def change
    add_column :invoice_emails, :cc, :string
    add_column :invoice_emails, :bcc, :string
  end
end
