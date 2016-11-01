class AddContactIdToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :primary_contact_id, :integer
  end
end
