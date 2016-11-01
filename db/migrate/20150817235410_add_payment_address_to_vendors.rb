class AddPaymentAddressToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :payment_address, :integer
  end
end
