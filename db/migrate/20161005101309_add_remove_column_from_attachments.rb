class AddRemoveColumnFromAttachments < ActiveRecord::Migration
  def up
  	remove_column :attachments, :bill_id
  	add_column :attachments, :referenceable_id, :integer 
  	add_column :attachments, :referenceable_type, :string

  	add_index :attachments, :referenceable_id
    add_index :attachments, :referenceable_type
  end

  def down
  	add_column :attachments, :bill_id, :integer
  end
end
