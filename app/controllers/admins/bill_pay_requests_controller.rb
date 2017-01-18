class Admins::BillPayRequestsController < Admins::ApplicationController
	load_and_authorize_resource :class => false

	def index
		@bills = Bill.where(paid: nil)
	end

	def show
		@bill = Bill.find(params[:id])
	end

	def payment
		if request.post?
			bill = Bill.find(params[:id])
			bill_information = BillInformation.find_or_create_by(bill_id: params[:id])
			bill_information.update_attributes(payment_params)
			bill_information.organization_id = bill.organization.id
			if bill_information.save
				bill.paid = true;
				bill.save
				redirect_to admins_bill_pay_requests_path
			end	

		else
			@bill=Bill.find(params[:id])
		end
	end

	private

	def payment_params
		params.require(:payment_info).permit(:vendor_name,
			:vendor_account,
			:bill_id,
			:processing_date,
			:memo,
			:description,
			:check_number,
			:due_date,
			:payment_method,
			:amount
			)
	end	
end
