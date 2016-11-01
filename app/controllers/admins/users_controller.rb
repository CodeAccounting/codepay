class Admins::UsersController < Admins::ApplicationController

	def index
		
	end

	def new
		
	end

	def show
		@user = User.find(params[:id])
		@billing_address = @user.billing_address
    	@shipping_address = @user.shipping_address
	end
end
