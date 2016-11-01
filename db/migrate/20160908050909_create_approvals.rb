class CreateApprovals < ActiveRecord::Migration
  def change
    create_table :approvals do |t|
    	t.integer :approvable_id
    	t.integer :assigned_by
    	t.integer :assigned_to
    	t.string  :approvable_type
    	t.string  :status, default: "Pending"	

      t.timestamps null: false
    end
	    add_index :approvals, :approvable_id
    	add_index :approvals, :assigned_by 
    	add_index :approvals, :assigned_to
  end
end
