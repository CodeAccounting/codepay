class ChartOfAccountsController < ApplicationController

	def index
		@chart_of_accounts = current_user.created_chart_of_accounts
	end

	def create
		chart_of_account = current_organization.chart_of_accounts.new(chart_of_account_params)
		chart_of_account.creator = current_user
		chart_of_account.save

		redirect_to chart_of_accounts_path
	end

	def show
		@chart_of_account = current_user.created_chart_of_accounts.find(params[:id])
	end

	def update
	end	

	private

	def chart_of_account_params
		params.require(:chart_of_accounts).permit(
			:name,
			:number,
			:description,
			:chart_of_account_type
			)
			
	end



end
