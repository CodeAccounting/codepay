class VoidsController < ApplicationController

	def index
		@bills = current_organization.bills.only_deleted 
	end
end
