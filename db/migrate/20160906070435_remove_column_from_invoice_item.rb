class RemoveColumnFromInvoiceItem < ActiveRecord::Migration
  def change
  	remove_column :invoice_items, :tax
  end
end
