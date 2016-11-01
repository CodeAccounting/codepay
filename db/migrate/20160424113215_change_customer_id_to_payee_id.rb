class ChangeCustomerIdToPayeeId < ActiveRecord::Migration
  def change
      rename_column :bills, :customer_id, :payee_id
  end
end
