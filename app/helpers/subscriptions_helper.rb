module SubscriptionsHelper
	
	def trial_remaining_days
	    if current_user.subscription.status == "trialing" 
	        end_date = current_user.subscription.ended_at
	        current_date = Time.now
	        days_left = (end_date.to_date-current_date.to_date).to_i.to_s
	      	return days_left
	    end
  	end

  	def period_continue 
        continue = current_user.subscription.continue
        return continue  	
    end
end
