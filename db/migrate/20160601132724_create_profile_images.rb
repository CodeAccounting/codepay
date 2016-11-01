class CreateProfileImages < ActiveRecord::Migration
  def change
    create_table :profile_images do |t|
    	t.integer :user_id
    	t.attachment :file

      t.timestamps null: false
    end
  end
end
