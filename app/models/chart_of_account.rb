class ChartOfAccount < ActiveRecord::Base

	belongs_to :creator, class_name: 'User'
	belongs_to :organization
	
end
