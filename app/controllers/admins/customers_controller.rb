class Admins::CustomersController < Admins::ApplicationController

	def show
		@customer = current_organization.customers.find(params[:id])
		@invoices = @customer.invoices
	end
end
