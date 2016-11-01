class CreateBillItems < ActiveRecord::Migration
  def change
    create_table :bill_items do |t|
      t.integer :bill_id
      t.integer :item_id
      t.string 	:description
      t.integer :quantity
      t.decimal :price,          precision: 8, scale: 2
      t.integer :location_id
      t.boolean :tax,            default: false
      t.decimal :amount,         precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
