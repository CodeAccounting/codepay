class ContactsController < ApplicationController
   def index
    @email = current_organization.customers.find(params[:id]).primary_contact
    render json: @email
   end

   def create
     @contact = current_organization.contacts.new(contact_params)

     if @contact.save
       render json: @contact
     else
       render json: @contact.errors.full_messages, status: :unprocessable_entity
     end
   end

   private

   def contact_params
     params
       .require(:contact)
       .permit(:first_name, :last_name, :email, :phone, :fax)
   end
end
