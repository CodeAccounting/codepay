class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
    	t.integer 		:user_id
    	t.string  		:subscription_id
    	t.datetime  	:started_at
    	t.datetime  	:ended_at
    	t.string  		:plan_id
    	t.string  		:plan_name
    	t.string 		  :status, default: "inactive" 
      t.boolean     :continue, default: true 

      t.timestamps null: false
    end
  end
end
