class AddCustomerNameToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :customer_name, :string
    add_column :invoices, :invoice_number, :string
    add_column :invoices, :record_date, :datetime
    add_column :invoices, :due_amount, :integer
    add_column :invoices, :terms, :string
    add_column :invoices, :location, :string
    add_column :invoices, :department, :string
    add_column :invoices, :job, :string
    add_column :invoices, :message, :text
    add_column :invoices, :notes, :text


    add_column :bills, :creator_id, :integer
    add_column :bills, :customer_name, :string
    add_column :bills, :message, :text
    add_column :bills, :location, :string
    add_column :bills, :department, :string
    add_column :bills, :job, :string
    add_column :bills, :invoice_date, :datetime
    add_column :bills, :terms, :string
    add_column :bills, :due_date, :datetime
    add_column :bills, :payment_date, :datetime
    add_column :bills, :orignal_amount, :integer
    add_column :bills, :due_amount, :integer
    add_column :bills, :last_sent, :string
    add_column :bills, :total_sent, :string
  end
end
