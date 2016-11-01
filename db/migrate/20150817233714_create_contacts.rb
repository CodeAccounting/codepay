class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :payment_info_email
      t.string :payment_info_phone
      t.string :phone
      t.string :fax

      t.timestamps null: false
    end

    add_index :contacts, :email, unique: true
    add_index :contacts, :last_name
  end
end
