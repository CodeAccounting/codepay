class AddTermIdToBills < ActiveRecord::Migration
  def change
    add_column :bills, :term_id, :integer
    add_column :bills, :location_id, :integer
    add_column :bills, :department_id, :integer
  end
end
