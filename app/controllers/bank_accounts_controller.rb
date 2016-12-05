class BankAccountsController < ApplicationController
	before_action :set_account, only: [:show, :edit, :update]

	def index
		@accounts = current_organization.bank_accounts
	end

	def create
		@account = current_organization.bank_accounts.new(account_params)
		@account.creator = current_user
		if @account.save
			redirect_to bank_accounts_path  
		else
			flash[:errors] = @account.errors.full_messages
			redirect_to new_bank_account_path
		end 
	end

	def show
	end

	def new
	end

	def update
		if @account.update(account_params)
			redirect_to bank_account_path(@account)
		else
			flash[:errors] = @account.errors.full_messages
			redirect_to :back
		end	
	end

	private

	def set_account
     @account = current_organization.bank_accounts.find(params[:id])
    end

	def account_params
      params.require(:account)
      .permit(
      	:account_number, 
      	:bank_name,
      	:domestic_routing,
    	:domestic_account,
    	:swift_code,
    	:bank_address1,
    	:bank_address2,
    	:city
        )
    end
end
