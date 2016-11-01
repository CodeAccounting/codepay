class AddPrimaryContactIdToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :primary_contact_id, :integer
  end
end
