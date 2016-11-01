class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.string :company_name
      t.integer :parent_customer_id
      t.string :customer_type
      t.integer :contact_id, null: false
      t.string :account_number, null: false
      t.string :payment_terms
      t.string :description
      t.integer :billing_address_id, null: false
      t.integer :shipping_address_id

      t.timestamps null: false
    end

    add_index :customers, :name, unique: true
    add_index :customers, :account_number, unique: true
  end
end
