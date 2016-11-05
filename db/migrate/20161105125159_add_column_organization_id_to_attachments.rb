class AddColumnOrganizationIdToAttachments < ActiveRecord::Migration
  def change
  	add_column :attachments, :organization_id, :integer
  end
end
