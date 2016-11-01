class RemoveColumnFromInvoiceItems < ActiveRecord::Migration
  def change
  	remove_column :invoice_items, :name
  end
end
