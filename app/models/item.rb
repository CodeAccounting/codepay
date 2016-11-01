class Item < ActiveRecord::Base

	validates :name, uniqueness: { scope: :item_of, allow_blank: false}, presence: true
	validates_inclusion_of :item_of, :in => ["Invoice", "Bill"], presence: true

	belongs_to :creator, class_name: 'User'
	belongs_to :organization
		
end
