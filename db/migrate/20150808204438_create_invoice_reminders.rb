class CreateInvoiceReminders < ActiveRecord::Migration
  def change
    create_table :invoice_reminders do |t|
      t.integer :invoice_id, null: false
      t.datetime :sent_at, null: false
      t.integer :sender_id, null: false

      t.timestamps null: false
    end

    add_index :invoice_reminders, :invoice_id
    add_index :invoice_reminders, :sender_id
  end
end
