class RepeatingPaymentsController < ApplicationController
	before_action :set_repeating_payment, only: [:show, :edit, :update, :destroy]

	def index
		@repeating_payments = current_organization.repeating_payments
	end

	def new 
		@repeating_payment = current_organization.repeating_payments.new
	end

	def create
		@repeating_payment = current_user.created_repeating_payments.new(repeating_payment_params)
		@repeating_payment.organization = current_organization
		if @repeating_payment.save
			redirect_to repeating_payments_path
		else
			flash[:errors] = @repeating_payment.errors.full_messages
			redirect_to new_repeating_payment_path
		end	
	end

	def update
		if @repeating_payment.update_attributes(repeating_payment_params)
         	redirect_to repeating_payment_path(@repeating_payment) 
      	else
       		flash[:errors] = @repeating_payment.errors.full_messages
       		redirect_to edit_repeating_payment_path(@repeating_payment)
      	end  
	end

	def vendors_by_ajax
		vendors = current_organization.vendors.where("name ILIKE ?","%#{params[:term]}%")
		render json:{vendors: vendors, status: 'ok'}
	end

	private 

	def set_repeating_payment
      @repeating_payment = current_organization.repeating_payments.find(params[:id])
    end

	def repeating_payment_params
		params.require(:repeating_payment).permit(  
       		:vendor_id,
      		:description,
    	 	:next_due_date,
      		:days_in_advance,
      		:frequency,
      		:frequency_type,
    	 	:end_date,
       		:total_amount,
        	repeating_payment_items_attributes: [  
	    										   :id,
	    										   :account,
	                              			   	   :amount,
	                             			   	   :description,
	                             			   	   :_destroy
                                  				]
        )
	end
end
