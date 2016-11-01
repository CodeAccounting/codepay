class CreateBillApprovals < ActiveRecord::Migration
  def change
    create_table :bill_approvals do |t|
    	t.integer :bill_id
    	t.integer :assigned_by
    	t.integer :assigned_to
    	t.string  :status, default: "Pending"	

      	t.timestamps null: false
    end
    	add_index :bill_approvals, :bill_id 
    	add_index :bill_approvals, :assigned_by 
    	add_index :bill_approvals, :assigned_to
  end
end
