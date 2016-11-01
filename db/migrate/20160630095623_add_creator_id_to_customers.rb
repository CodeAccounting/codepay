class AddCreatorIdToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :creator_id, :integer
    add_column :payees, :creator_id, :integer
  end
end
