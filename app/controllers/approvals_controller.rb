class ApprovalsController < ApplicationController

	def index
		@approvals = current_user.approvals.where(:status=> "Pending")
	end

	def show
		@approval = current_user.approvals.find_by(:approvable_id => params[:id]) 
		if @approval.present? && @approval.approvable_type == "Bill"
		   @bill_info = @approval.approvable
		# elsif @approval.present? && @approval.approvable_type == "Invoice"
		#    @invoice = @approval.approvable	   	
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

	def bill_approver_list_by_ajax
		if params[:id].present? && params[:type] == "Bill"
		   approvals = Bill.find(params[:id]).approvals
		   render json: approvals.to_json(:include => :assignee)
		end	
	end

	def approvers_select2_ajax
		if params[:type]=="Bill"  
		   	bill_approvar_ids = current_organization.bills.find(params[:id]).approvals.map(&:assigned_to)
		   	organization_approver_ids = current_organization.all_organization_users.select{|a| 
				(a.invitation_accepted_at !=  nil && a.which_role?(current_organization) == "approver")}.map(&:id)
			approver_left_ids = organization_approver_ids-bill_approvar_ids
		   	approvars = current_organization.all_organization_users.where(id: approver_left_ids).where("first_name ILIKE ?","%#{params[:term]}%")
			respond_to do |format|
	          format.json { render :json => approvars }
        	end 
		end
		
		if params[:approver_ids].present? && params[:approvable_type]=="Bill"
		   bill = current_organization.bills.find(params[:approvable_id])
		   approvals = []
			params[:approver_ids].each do |approver|
				approvals << bill.approvals.create(assigned_by: bill.creator.id, assigned_to: approver)
			end
	        render json: approvals.each.to_json(:include => :assignee)
		end	
	end
end
