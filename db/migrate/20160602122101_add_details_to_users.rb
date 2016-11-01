class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mailing_address, :string
    add_column :users, :dob, :datetime
    add_column :users, :billing_address_id, :integer
    add_column :users, :shipping_address_id, :integer
  end
end
