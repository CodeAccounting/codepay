class CreateInvoicePayments < ActiveRecord::Migration
  def change
    create_table :invoice_payments do |t|
      t.integer  :creator_id
      t.integer  :organization_id
      t.integer  :invoice_id
      t.integer  :routing_number    
      t.integer  :account_number
      t.string   :bank_name 
      t.string   :iban   
      t.string   :swift 
      t.string   :memo 
      t.string   :email ,null: false
  
      t.timestamps null: false

    end
    add_index :invoice_payments, [:creator_id] 
    add_index :invoice_payments, [:organization_id] 
    add_index :invoice_payments, [:invoice_id ]
  end
end
