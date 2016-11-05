class AttachmentsController < ApplicationController
	protect_from_forgery with: :exception, except: [:attachment_via_ajax]


	def index
		@attachments = current_organization.attachments.where(referenceable_id: nil, attachable_type: "User")

		respond_to do |format|
			format.html { render :index }
	    	format.json {  render json: Attachment.attachments_for_json_response(current_user)}
	    end	

	end
	
	def create
		if params[:document].present?
			upload_params[:attachment].each do |ar_val|
				upload_param = {'attachment' => ar_val}
	    		attach_document = current_user.attachments.new(upload_param)
	    		attach_document.organization_id = current_organization.id
        		attach_document.save
        		attach_document = nil 
        	end    
	    	redirect_to attachments_path
	    else
	    	flash[:error]= "Please Attach Atleast One Document"
	    	redirect_to :back
	    end	
   	end  
	
	def update
	end

	def show
	end

	def delete_files
		if params[:attachment].present?
		   	attachments = current_user.attachments.where(:id => delete_params[:attachment_ids], :bill_id => nil)
		   	attachments.destroy_all
		   	redirect_to attachments_path		   
		else
			flash[:error]= "Please Select Document To Delete"
	    	redirect_to :back
		end	
	end	

	def attachment_via_ajax
		attach_param = {'attachment' => params[:attachment] }
		attach_document = current_user.attachments.new(attach_param)
		attach_document.organization_id = current_organization.id
		if attach_document.save
			# id = attach_document.id
			render json: {'attachment': attach_document, 'url': attach_document.attachment.url}
		end	
	end

	private

	def delete_params
		params.require(:attachment).permit(:attachment_ids=>[])
	end	
	def upload_params
		params.require(:document).permit(:attachment=>[])
	end
end
