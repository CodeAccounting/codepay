class RepeatingPayment < ActiveRecord::Base

	
	belongs_to :creator, class_name: 'User'
	belongs_to :vendor, class_name: 'Vendor'
	belongs_to :organization

	has_many :repeating_payment_items
	
	accepts_nested_attributes_for :repeating_payment_items, :allow_destroy => true,  reject_if: proc { |attributes| (attributes['amount'].blank?) }

	def self.to_csv(options = {})
	    CSV.generate(options) do |csv|
	      csv << [
	        "Vendor Name",
	        "Next Due Date",
	        "Days In Advance",
	        "Frequency",
	        "End Date",
	        "Total Amount"
	      ]
	      all.each do |repeating_payment|
	        csv << [
	          repeating_payment.vendor.name,
	          repeating_payment.try(:next_due_date).strftime("%d %B %Y"),
              repeating_payment.try(:days_in_advance), 
              repeating_payment.try(:frequency), 
              repeating_payment.try(:end_date).strftime("%d %B %Y"),
              repeating_payment.try(:total_amount)
	        ]
	      end
	    end
	end

end

