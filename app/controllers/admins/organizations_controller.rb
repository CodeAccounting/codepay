class Admins::OrganizationsController < Admins::ApplicationController

	def show
		@organization = Organization.find(params[:id])
		@users=@organization.all_organization_users
	end
end
