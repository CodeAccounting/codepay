class AddOrganizationIdToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :organization_id, :integer
    add_index :contacts, :organization_id
  end
end
