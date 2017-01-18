class RemoveAddColumnToBankAccount < ActiveRecord::Migration
  def up
    remove_column :bank_accounts, :account_number
  	remove_column :bank_accounts, :payable
  	remove_column :bank_accounts, :default
  	remove_column :bank_accounts, :receivable
  	remove_column :bank_accounts, :status
  	remove_column :bank_accounts, :active
  	
    add_column :bank_accounts, :account_number, :string
  	add_column :bank_accounts, :domestic_routing, :string
  	add_column :bank_accounts, :domestic_account, :string
  	add_column :bank_accounts, :swift_code, :string
  	add_column :bank_accounts, :bank_address1, :text
  	add_column :bank_accounts, :bank_address2, :text
  	add_column :bank_accounts, :city, :string

  end

  def down
    remove_column :bank_accounts, :account_number
  	remove_column :bank_accounts, :domestic_routing
  	remove_column :bank_accounts, :domestic_account 
  	remove_column :bank_accounts, :swift_code
  	remove_column :bank_accounts, :bank_address1
  	remove_column :bank_accounts, :bank_address2
  	remove_column :bank_accounts, :city

    add_column :bank_accounts, :account_number, :integer
  	add_column :bank_accounts, :payable, :string
  	add_column :bank_accounts, :default, :string
  	add_column :bank_accounts, :receivable, :string
  	add_column :bank_accounts, :status, :string
  	add_column :bank_accounts, :active, :string
 
  end
end
