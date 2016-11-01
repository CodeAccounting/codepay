class AddColumnAdminCurrentOrganizationIdToUser < ActiveRecord::Migration
  def change
  	add_column :users, :current_admin_organization_id, :integer
  end
end
