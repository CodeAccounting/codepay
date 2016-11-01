class CreateBillInformations < ActiveRecord::Migration
  def change
    create_table :bill_informations do |t|
      t.integer   :organization_id
      t.integer   :bill_id
      t.integer   :transaction_number
      t.string    :payment_type
      t.datetime  :processing_date
      t.datetime  :deposit_date
      t.datetime  :arrival_date
      t.datetime  :due_date
      t.integer   :account_used
      t.string    :vendor_name
      t.integer   :vendor_account
      t.text      :memo
      t.text      :description
      t.integer   :check_number
      t.integer   :authorizer_id
      t.datetime  :authorization_date
      t.datetime  :approver_id
      t.datetime  :approval_date

      t.timestamps null: false
    end
  end
end
