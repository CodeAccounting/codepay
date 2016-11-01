class AddSgMessageIdToInvoiceEmails < ActiveRecord::Migration
  def change
    add_column :invoice_emails, :sg_message_id, :string
  end
end
