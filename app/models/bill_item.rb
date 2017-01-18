class BillItem < ActiveRecord::Base

	belongs_to :bill
	belongs_to :location
	belongs_to :item
	belongs_to :tax
end
