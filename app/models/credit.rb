class Credit < ActiveRecord::Base

	validates :vendor_id, presence: true 
	validates :bill_id, presence: true 
	validates :credit_amount, presence: true 

	belongs_to :creator, class_name: 'User'
	belongs_to :organization
	belongs_to :vendor
	belongs_to :bill

	def self.to_csv(options = {})
	    CSV.generate(options) do |csv|
	      csv << [
	        "Vendor Name",
	        "Bill Number",
	        "Credit Amount",
	        "Message",
	        "Credit Date",
	        "Status"
	      ]
	      all.each do |credit|
	        csv << [
	        credit.vendor.name,
	        credit.bill.bill_number,
			credit.try(:credit_amount),
			credit.try(:message),
			credit.try(:credit_date).strftime("%d %B %Y"),
			credit.try(:credit_status)
	        ]
	      end
	    end
  	end
	
	def credit_status
		if self.status
			"Applied" 
		else
			"Not Applied"
		end	
	end

end
