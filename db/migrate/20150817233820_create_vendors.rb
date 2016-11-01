class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.string :vendor_name, null: false
      t.string :pay_to, null: false
      t.string :company_name, null: false
      t.string :vendor_type
      t.text :description

      t.timestamps null: false
    end

    add_index :vendors, :vendor_name, unique: true
  end
end
