class AddReceivedToInvoice < ActiveRecord::Migration
  def change
  	add_column :invoices, :received, :boolean, default: false
  end
end
