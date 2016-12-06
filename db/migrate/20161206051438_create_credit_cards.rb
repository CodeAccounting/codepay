class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|

    	t.integer  :creator_id
    	t.integer  :organization_id
    	t.string   :card_number
    	t.datetime :expiration_date
    	t.string   :cvv_code
    	t.string   :card_type
    	t.string   :billing_zip_code
    	t.string   :name
    	t.text     :address

      t.timestamps null: false
    end
  end
end
