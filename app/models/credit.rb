class Credit < ActiveRecord::Base

	validates :vendor_id, presence: true 
	validates :bill_id, presence: true 
	validates :credit_amount, presence: true 

	belongs_to :creator, class_name: 'User'
	belongs_to :organization
	belongs_to :vendor
	belongs_to :bill


	def credit_status
		if self.status
			"Applied" 
		else
			"Not Applied"
		end	
	end
end
