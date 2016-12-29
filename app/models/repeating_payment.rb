class RepeatingPayment < ActiveRecord::Base

	
	belongs_to :creator, class_name: 'User'
	belongs_to :vendor, class_name: 'Vendor'
	belongs_to :organization

	has_many :repeating_payment_items
	
	accepts_nested_attributes_for :repeating_payment_items, :allow_destroy => true,  reject_if: proc { |attributes| (attributes['amount'].blank?) }
end
