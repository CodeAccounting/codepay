class ItemsController < ApplicationController

	def index
		@invoice_items = current_organization.items.where(item_of: "Invoice")
		@bill_items = current_organization.items.where(item_of: "Bill")
	end

	def show
		@item = current_organization.items.find(params[:id])
	end

	def create
		@item = current_organization.items.new(item_params)
		@item.creator = current_user

		if @item.save
	       render json: @item
	    else
	       render json: @item.errors.full_messages, status: :unprocessable_entity
	    end
	end

	def remove_item
		item = current_organization.items.find(params[:id])
		item.destroy
		redirect_to items_path
	end

	def item_params
		params.require(:item).permit(:name, :item_of)
	end
end
