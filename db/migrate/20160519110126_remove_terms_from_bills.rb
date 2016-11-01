class RemoveTermsFromBills < ActiveRecord::Migration
  def change
    remove_column :bills, :terms, :string
    remove_column :bills, :location, :string
    remove_column :bills, :department, :string
  end
end
