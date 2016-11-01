class Audit < ActiveRecord::Base

	belongs_to :auditable,  polymorphic: true
	belongs_to :user ,polymorphic: true
	serialize :audited_changes, Hash

end
