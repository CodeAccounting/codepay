class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
    	t.integer :creator_id
    	t.integer :organization_id
    	t.string  :name
    	t.string  :item_of

      t.timestamps null: false
    end
  end
end
