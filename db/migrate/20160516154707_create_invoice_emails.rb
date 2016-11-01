class CreateInvoiceEmails < ActiveRecord::Migration
  def change
    create_table :invoice_emails do |t|
      t.integer :sender_id
      t.integer :invoice_id
      t.string :to_email
      t.string :from_email
      t.string :subject
      t.text :raw_content
      t.string :status

      t.timestamps null: false
    end
  end
end
