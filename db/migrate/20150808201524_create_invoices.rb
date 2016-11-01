class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.datetime :due_date, null: false
      t.integer :creator_id, null: false

      t.timestamps null: false
    end

    add_index :invoices, :creator_id
  end
end
