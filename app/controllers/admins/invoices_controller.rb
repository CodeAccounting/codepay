class Admins::InvoicesController < Admins::ApplicationController

	def index
		@invoices = current_organization.invoices
	end

	def show
		@invoice = current_organization.invoices.find(params[:id])
	end
end
