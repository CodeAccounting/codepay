module DashboardsHelper

	def approval_required_link
		if current_user.approvals.present? 
    		current_user.approvals.where(:status => "Pending").present? ? approvals_path : "javascript:;"
  		else
    		"javascript:;"
  		end 
	end

	def new_document_link
		if current_user.attachments.present? 
     		current_user.attachments.where(:referenceable_id => nil).present? ? attachments_path : "javascript:;"
  		else
     		"javascript:;"
  		end
	end

	def unpaid_bills_link
		if current_organization.bills.present? 
     		current_organization.bills.where("paid" => false).present? ? new_payment_path : "javascript:;"
  		else
     		"javascript:;"
  		end
	end

	def outstanding_invoice_link
		if current_organization.invoices.present? 
     		invoices_path
  		else
     		"javascript:;"
  		end
	end

  def trial_remaining_days
    if current_user.subscription.status == "trialing" 
        end_date = current_user.subscription.ended_at
        current_date = Time.now
        days_left = (end_date.to_date-current_date.to_date).to_i.to_s
    end
      return days_left    
  end
  
end
