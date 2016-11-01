class AddTableVendors < ActiveRecord::Migration
  def up
  	drop_table :payees
  	drop_table :vendors
  	create_table :vendors do |t|
      t.string :name 
      t.integer :creator_id
      t.integer :parent_vendor_id
      t.string :company_name
      t.string :vendor_type
      t.integer :contact_id
      t.string :account_number
      t.string :payment_terms
      t.string :description      
      t.integer :billing_address_id 
      t.integer :shipping_address_id
      t.integer :organization_id 
      t.integer :primary_contact_id 
      t.timestamps null: false
    end  
  end

  def down
    drop_table :vendors
    create_table :vendors
    create_table :payees
  end
end
