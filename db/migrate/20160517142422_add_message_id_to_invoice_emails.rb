class AddMessageIdToInvoiceEmails < ActiveRecord::Migration
  def change
    add_column :invoice_emails, :message_id, :string
  end
end
