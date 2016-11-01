class BillApproval < ActiveRecord::Base

	belongs_to :bill
	belongs_to :assignee, class_name: 'User', foreign_key: :assigned_to
	belongs_to :assigner, class_name: 'User', foreign_key: :assigned_by
end
