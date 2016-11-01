class CreateTableInvoices < ActiveRecord::Migration
  def change
    suppress_messages do
      create_table :invoices do |t|
        t.integer  :creator_id,         null: false
        t.integer  :customer_id,        null: false
        t.string   :invoice_number,     null: false
        t.datetime :invoice_date,       null: false
        t.datetime :due_date,           null: false
        t.decimal  :due_amount,         precision: 8, scale: 2
        t.integer  :invoice_template_id
        t.integer  :payment_term_id
        t.integer  :location_id
        t.integer  :department_id
        t.string   :po_number
        t.string   :sales_rep
        t.text     :message

        t.datetime :deleted_at
        t.timestamps null: false
      end
    end

    say "Created a table 'invoices'"

    suppress_messages { add_index :invoices, :creator_id }
    say "and an index on 'creator_id'", true
  end
end
