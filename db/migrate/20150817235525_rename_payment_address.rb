class RenamePaymentAddress < ActiveRecord::Migration
  def change
    rename_column :vendors, :payment_address, :payment_address_id
  end
end
