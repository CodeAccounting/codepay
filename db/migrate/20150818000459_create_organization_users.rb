class CreateOrganizationUsers < ActiveRecord::Migration
  def change
    create_table :organization_users do |t|
      t.integer :organization_id
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :organization_users, [:organization_id, :user_id], unique: true
  end
end
