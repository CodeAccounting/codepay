class Admins::AdminUsersController < Admins::ApplicationController
		load_and_authorize_resource :class => false

	def index
		@admin_users = Admin.all.where.not(role: "Admin")		
	end
end
