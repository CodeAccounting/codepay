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

	def approve_bills
		if params[:approval_ids].present?
			approvals = Approval.where(id: params[:approval_ids],  assigned_to: current_user.id)
			approvals.update_all(status: "Approved")
			redirect_to approvals_path
		else
		 flash[:error]= "Please Select At Least One Bill"
      	 redirect_to :back
		end	
	end

	def assign_request_to_other_user
		if params[:approval_ids].present? && params[:assigned_to_ids].present?
			approvals = Approval.where(id: params[:approval_ids],  assigned_to: current_user.id)
			params[:assigned_to_ids].each do |assigned_to_id|
				approvals.each do |approval|
					Approval.create(approvable_id: approval.approvable_id , 
						assigned_by: approval.assigned_by, assigned_to: assigned_to_id, 
						approvable_type: approval.approvable_type, status: approval.status)
				end
			end	
			approvals.delete_all
			redirect_to approvals_path		
		else
		  flash[:error]= "You must select atleast one bill and atleast one approval to assign"
      	 redirect_to :back
		end
	end

end
