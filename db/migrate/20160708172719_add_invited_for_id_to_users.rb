class AddInvitedForIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :invited_for_id, :integer
  end
end
