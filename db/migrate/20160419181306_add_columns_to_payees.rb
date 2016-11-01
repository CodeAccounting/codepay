class AddColumnsToPayees < ActiveRecord::Migration
  def change
    add_column :payees, :name, :string
    add_column :payees, :company_name, :string
    add_column :payees, :parent_payee_id, :integer
    add_column :payees, :payee_type, :string
    add_column :payees, :contact_id, :integer
    add_column :payees, :account_number, :string
    add_column :payees, :payment_terms, :string
    add_column :payees, :description, :string
    add_column :payees, :billing_address_id, :integer
    add_column :payees, :shipping_address_id, :integer
    add_column :payees, :organization_id, :integer
    add_column :payees, :primary_contact_id, :integer
  end
end
