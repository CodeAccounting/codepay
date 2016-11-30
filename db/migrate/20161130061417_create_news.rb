class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
    	t.text :subject
    	t.text :description
    			
      t.timestamps null: false
    end
  end
end
