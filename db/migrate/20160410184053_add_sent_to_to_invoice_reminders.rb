class AddSentToToInvoiceReminders < ActiveRecord::Migration
  def change
    add_column :invoice_reminders, :sent_to, :string
  end
end
