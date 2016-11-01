class BillApprovalsController < ApplicationController

	def index
		@bills_for_approval = current_user.bill_approvals.where(:status=> "Pending")
	end

	def show
		@bill_approval = current_user.bill_approvals.find_by(:bill_id => params[:id]) 
		if @bill_approval.present?
		@bill_info = @bill_approval.bill	
		end
	end

	def update
		bill_for_approval = current_user.bill_approvals.find(params[:id])
		if bill_for_approval.present?
			bill_for_approval.update(status: params[:apparoval])
		end
		redirect_to bill_approvals_path
	end
end
 