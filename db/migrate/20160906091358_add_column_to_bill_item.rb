class AddColumnToBillItem < ActiveRecord::Migration
  def change
  	add_column :bill_items, :tax_id, :integer
  end
end
