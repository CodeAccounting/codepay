class DropTableInvoicePayments < ActiveRecord::Migration
  
  def up
  	drop_table :invoice_payments
  	create_table :invoice_payments do |t|

  	  t.integer  :creator_id
      t.integer  :organization_id
      t.integer  :invoice_id
      t.datetime :date  
      t.string   :payment_method
      t.string   :payment_account
      t.string   :reference 
      t.text     :message   
      t.decimal  :payment_amount, precision: 8, scale: 2
  
      t.timestamps null: false

    end  
  end

  def down
    drop_table :invoice_payments
    create_table :invoice_payments do |t|
    end  
  end

end
