class CreateRepeatingPayments < ActiveRecord::Migration
  def change
    create_table :repeating_payments do |t|
    	
    	t.integer  :creator_id
      t.integer  :organization_id
      t.integer  :vendor_id
    	t.text     :description
    	t.datetime :next_due_date
    	t.integer  :days_in_advance
    	t.integer  :frequency
    	t.string   :frequency_type
    	t.datetime :end_date
      t.decimal  :total_amount

      t.timestamps null: false
    end
  end
end
