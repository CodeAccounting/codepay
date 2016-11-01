class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :creator_id
      t.integer :organization_id
      t.integer :noteable_id
      t.string  :noteable_type
      t.text    :body

      t.timestamps null: false
    end
  end
end
