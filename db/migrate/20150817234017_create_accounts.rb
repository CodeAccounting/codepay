class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :tax_id, null: false
      t.boolean :is_vendor_1099, null: false, default: false
      t.string :account_number, null: false
      t.date :vendor_since
      t.integer :lead_time, null: false, default: 0
      t.string :payment_terms
      t.boolean :combine_payments, null: false, default: false

      t.timestamps null: false
    end

    add_index :accounts, :tax_id, unique: true
    add_index :accounts, :account_number, unique: true
  end
end
