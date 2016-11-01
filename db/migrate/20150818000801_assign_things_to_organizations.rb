class AssignThingsToOrganizations < ActiveRecord::Migration
  def change
    add_column :customers, :organization_id, :integer
    add_column :vendors, :organization_id, :integer
  end
end
