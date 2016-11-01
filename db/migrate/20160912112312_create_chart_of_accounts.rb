class CreateChartOfAccounts < ActiveRecord::Migration
  def change
    create_table :chart_of_accounts do |t|
    	t.integer :creator_id
    	t.integer :organization_id
    	t.string  :name
    	t.string  :number
    	t.string  :chart_of_account_type
    	t.string  :description

      t.timestamps null: false
    end
  end
end
