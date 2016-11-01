class AuditsController < ApplicationController

	def index
		@audits = Audit.where(:user_id => current_user.id)
	end
end
