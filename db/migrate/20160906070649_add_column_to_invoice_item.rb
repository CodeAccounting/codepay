class AddColumnToInvoiceItem < ActiveRecord::Migration
  def change
  	add_column :invoice_items, :tax_id, :integer
  end
end
