class CreateIdentifications < ActiveRecord::Migration
  def change
    create_table :identifications do |t|
    	t.integer :user_id
    	t.attachment :file
    	t.string :doc_type

      t.timestamps null: false
    end
  end
end
