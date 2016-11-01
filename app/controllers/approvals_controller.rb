class ApprovalsController < ApplicationController

	def index
		@approvals = current_user.approvals.where(:status=> "Pending")
	end

	def show
		@approval = current_user.approvals.find_by(:approvable_id => params[:id])
		type = params[:format] 
		if @approval.present? && type == "Bill"
		   @bill_info = @approval.approvable
		elsif @approval.present? && type == "Invoice"
		   @invoice = @approval.approvable	   	
		end
	end

	def update
		approval = current_user.approvals.find(params[:id])
		if approval.present?
			approval.update(status: params[:apparoval])
		end
		redirect_to approvals_path
	end
end
