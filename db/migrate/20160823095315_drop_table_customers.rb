class DropTableCustomers < ActiveRecord::Migration
  def up
  	drop_table :customers
  	create_table :customers do |t|
      t.string  :name 
      t.string  :company_name
      t.integer :parent_customer_id
      t.string  :customer_type
      t.integer :contact_id
      t.string  :account_number
      t.string  :payment_terms
      t.string  :description
      t.integer :billing_address_id
      t.integer :shipping_address_id
      t.integer :organization_id
      t.integer :primary_contact_id
      t.integer :creator_id

      t.timestamps null: false
    end

    add_index :customers, :name
    add_index :customers, :account_number
  end

  def down
    drop_table :customers
    create_table :customers do |t|
    end  
  end

end
