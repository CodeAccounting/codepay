class ChangeCustomerTypeInInvoices < ActiveRecord::Migration
  def up
    remove_column :invoices, :customer_name
    remove_column :bills, :customer_name
  end

  def down
    add_column :invoices, :customer_name, :string
    add_column :bills, :customer_name, :string
  end
end
