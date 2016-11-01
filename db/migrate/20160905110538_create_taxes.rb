class CreateTaxes < ActiveRecord::Migration
  def change
    create_table :taxes do |t|
    	t.integer :creator_id
    	t.integer :organization_id
    	t.decimal :tax, precision: 5, scale: 2
    	t.string  :tax_of		
      t.timestamps null: false
    end
  end
end
