class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
    	t.integer :creator_id
    	t.integer :organization_id
    	t.integer :vendor_id
    	t.integer :bill_id
    	t.decimal :credit_amount
    	t.datetime :credit_date
    	t.text     :message
      t.boolean  :status, default: false

      t.timestamps null: false
    end
  end
end
