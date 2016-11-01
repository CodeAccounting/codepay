class AddPaidToBills < ActiveRecord::Migration
  def change
    add_column :bills, :paid, :boolean, default: false
  end
end
