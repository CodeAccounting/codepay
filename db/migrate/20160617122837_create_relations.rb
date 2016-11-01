class CreateRelations < ActiveRecord::Migration
  def change
    create_table :relations do |t|
      t.integer :user_id
      t.integer :organization_id
      t.string :user_type

      t.timestamps null: false
    end
  end
end
