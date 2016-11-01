class AddTypeToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :organization_type, :string
    add_column :organizations, :accounting_software, :string
  end
end
