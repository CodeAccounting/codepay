class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :attachable_id
      t.integer :bill_id
      t.string  :attachable_type
      t.attachment :attachment
      
      t.timestamps null: false 
    end
  end
end
