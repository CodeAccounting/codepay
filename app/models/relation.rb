class Relation < ActiveRecord::Base
	# validates :user_type, uniqueness: { scope: [:user_id, :organization_id], allow_blank: false }
	validates :user_id, uniqueness: { scope: :organization_id, allow_blank: false}

	validates_inclusion_of :user_type, :in => ['admin', 'accountant', 'payer', 'approver', 'clerk']

	belongs_to :admin_organization, class_name: 'Organization', foreign_key: 'organization_id'
	belongs_to :user_organization, class_name: 'Organization', foreign_key: 'organization_id'
	belongs_to :all_organization, class_name: 'Organization', foreign_key: 'organization_id'
	
	# belongs_to :organization_admin, class_name: 'User', foreign_key: 'user_id'
	belongs_to :all_organization_user, class_name: 'User', foreign_key: 'user_id'
end
