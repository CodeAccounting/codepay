class Tax < ActiveRecord::Base
	# validates :tax, uniqueness: { scope: :item_of, allow_blank: false}, presence: true
	validates_inclusion_of :tax_of, :in => ["Invoice", "Bill"], presence: true

	belongs_to :creator, class_name: 'User'
	belongs_to :organization

end
