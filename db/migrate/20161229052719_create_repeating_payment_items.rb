class CreateRepeatingPaymentItems < ActiveRecord::Migration
  def change
    create_table :repeating_payment_items do |t|
    	
    	t.integer :repeating_payment_id
    	t.string  :account
    	t.decimal :amount
    	t.text 	  :description 
     
      t.timestamps null: false
    end
  end
end
