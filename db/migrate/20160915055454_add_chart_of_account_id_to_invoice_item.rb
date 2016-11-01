class AddChartOfAccountIdToInvoiceItem < ActiveRecord::Migration
  def change
  	add_column :invoice_items, :chart_of_account_id, :integer
  end
end
