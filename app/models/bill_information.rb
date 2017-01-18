class BillInformation < ActiveRecord::Base
	belongs_to :bill
	belongs_to :organization
end
