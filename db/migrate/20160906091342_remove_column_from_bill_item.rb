class RemoveColumnFromBillItem < ActiveRecord::Migration
  def change
  	remove_column :bill_items, :tax
  end
end
