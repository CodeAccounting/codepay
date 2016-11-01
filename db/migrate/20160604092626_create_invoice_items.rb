class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|
      t.integer :invoice_id
      t.string :name
      t.string :description
      t.integer :quantity
      t.decimal :price,          precision: 8, scale: 2
      t.integer :location_id
      t.boolean :tax,            default: false
      t.decimal :amount,         precision: 8, scale: 2

      t.timestamps null: false
    end
    add_index :invoice_items, :invoice_id
  end
end
