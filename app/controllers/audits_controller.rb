class AuditsController < ApplicationController
	load_and_authorize_resource

	def index
		@audits = Audit.where(associated_id: current_organization.id, associated_type: "Organization", user_id: users_under_organization)
	end

  	private
  	def users_under_organization
		users = current_organization.all_organization_users.where.not(id: current_user)
		users.map(&:id)
	end
end
