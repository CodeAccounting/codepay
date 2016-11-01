class AddColumnToUser < ActiveRecord::Migration
  def change
  	add_column :users, :is_master, :boolean, default: false
  end
end
