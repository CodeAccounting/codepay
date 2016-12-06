class CreditCardsController < ApplicationController
	before_action :set_credit_card, only: [:show, :edit, :update, :destroy]

	def index
		@credit_cards = current_organization.credit_cards
	end

	def new
		
	end

	def show
	end

	def edit
	end

	def create
		@credit_card = current_organization.credit_cards.new(credit_card_params)
		@credit_card.creator = current_user
		if @credit_card.save
			redirect_to credit_cards_path
		else
			flash[:errors]= @credit_card.errors.full_messages
			redirect_to :back
		end 
	end

	def update
		if @credit_card.update_attributes(credit_card_params)
			redirect_to credit_card_path(@credit_card)
		else
			flash[:errors]= @credit_card.errors.full_messages
			redirect_to :back
		end	
	end

	private 
	def set_credit_card
     @credit_card = current_organization.credit_cards.find(params[:id])
    end

	def credit_card_params
      params.require(:credit_card)
      .permit(
      	:card_number,
    	:expiration_date,
    	:cvv_code,
    	:card_type,
    	:billing_zip_code,
    	:name,
    	:address
        )
    end
end
