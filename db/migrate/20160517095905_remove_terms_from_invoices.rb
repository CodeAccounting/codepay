class RemoveTermsFromInvoices < ActiveRecord::Migration
  def change
    remove_column :invoices, :terms, :string
    remove_column :invoices, :location, :string
    remove_column :invoices, :department, :string
  end
end
