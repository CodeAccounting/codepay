class AddTermIdToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :term_id, :integer
    add_column :invoices, :location_id, :integer
    add_column :invoices, :department_id, :integer
  end
end
