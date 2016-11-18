class CreditsController < ApplicationController

	def index
		@credits = current_organization.credits
	end

	def create 
		credit = current_organization.credits.new(credit_params)
		credit.creator = current_user
		if credit.save
			redirect_to credits_path
		else
			flash[:errors] = credit.errors.full_messages
			redirect_to new_credit_path
		end	 
	end

	def show
		@credit = current_organization.credits.find(params[:id])
	end

	private
	def credit_params
      params.require(:credit).permit(
        :vendor_id,
        :bill_id,
        :credit_date,
        :credit_amount,
        :message
        )
    end
end
