class DropTableBills < ActiveRecord::Migration
  def up
  	drop_table :bills
  	create_table :bills do |t|
      t.integer  :creator_id
      t.integer  :organization_id
      t.integer  :vendor_id
      t.string   :bill_number
	    t.datetime :bill_date       
      t.datetime :due_date           
      t.decimal  :due_amount,         precision: 8, scale: 2
      t.integer  :bill_template_id
      t.integer  :payment_term_id
      t.integer  :location_id
      t.integer  :department_id
      t.string   :po_number
      t.string   :sales_rep
      t.text     :message
      t.boolean :paid, default: false
      t.datetime :deleted_at
      t.timestamps null: false
    end  
  end

  def down
    drop_table :bills
    create_table :bills do |t|
    end  
  end
end
