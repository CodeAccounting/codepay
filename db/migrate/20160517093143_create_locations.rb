class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :creator_id
      t.string :name
    end

    create_table :departments do |t|
      t.integer :creator_id
      t.string :name
    end

    create_table :terms do |t|
      t.integer :creator_id
      t.string :name
    end
  end
end
