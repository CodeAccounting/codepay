class Subscription < ActiveRecord::Base
	belongs_to :user
	def self.create_from_response(user, response)
		sub = Subscription.new
		sub.user = user
		sub.subscription_id = response.id
		sub.started_at =Time.at(response.current_period_start)
		sub.ended_at = Time.at(response.current_period_end)
		sub.plan_id = response.plan.id
		sub.plan_name = response.plan.name
		sub.status = response.status
		sub.save
	end

	def subscription_for_old_customer(response)
		self.subscription_id = response.id
		self.started_at =Time.at(response.current_period_start)
		self.ended_at = Time.at(response.current_period_end)
		self.plan_id = response.plan.id
		self.plan_name = response.plan.name
		self.status = response.status
		self.save
	end

	def trial_subscription_upgrade(response)
		self.subscription_id = response.id
		self.started_at =Time.at(response.current_period_start)
		self.ended_at = Time.at(response.current_period_end)
		self.plan_id = response.plan.id
		self.plan_name = response.plan.name
		self.status = response.status
		self.continue = true
		self.save
	end

	def subscription_invoice_failed(response)
		self.subscription_id = response.id
		self.started_at =Time.at(response.current_period_start)
		self.ended_at = Time.at(response.current_period_end)
		self.plan_id = response.plan.id
		self.plan_name = response.plan.name
		self.status = response.status
		self.save
	end

	def active_subscription_upgrade(response)
		self.subscription_id = response.id
		self.started_at =Time.at(response.current_period_start)
		self.ended_at = Time.at(response.current_period_end)
		self.plan_id = response.plan.id
		self.plan_name = response.plan.name
		self.status = response.status
		self.continue = true
		self.save
	end
end
