class AddColumnsToBillInformation < ActiveRecord::Migration
  def change
  	add_column :bill_informations, :payment_method, :string
  	add_column :bill_informations, :amount, :decimal
  	add_column :bill_informations, :delivery_date, :datetime
  end
end
