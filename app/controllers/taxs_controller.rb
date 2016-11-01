class TaxsController < ApplicationController

	def index
	end

	def create
     	@tax = current_organization.taxs.new(tax_params)
     	@tax.creator = current_user
     	if @tax.save
       	  render json: @tax
     	else
     	  render json: @tax.errors.full_messages, status: :unprocessable_entity
     	end
   	end

   private

   def tax_params
   	 	params.require(:tax).permit(:tax, :tax_of)
   end
end
