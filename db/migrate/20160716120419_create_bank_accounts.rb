class CreateBankAccounts < ActiveRecord::Migration
  def change
    create_table :bank_accounts do |t|
      t.integer :creator_id
      t.integer :organization_id
      t.integer :account_number
      t.string :bank_name
      t.string :payable  , default: "Yes" 
      t.string :default  , default: "Yes"
      t.string :receivable 
      t.string :status , default: "Varified"
      t.string :active , default: "Active"


      t.timestamps null: false
    end
    add_index :bank_accounts, [:creator_id, :organization_id]
  end
end
