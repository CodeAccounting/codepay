class RemoveIndexFromOrganizations < ActiveRecord::Migration
  def change
    remove_index :organizations, :name
    remove_index :organization_users, [:organization_id, :user_id]
  end
end
