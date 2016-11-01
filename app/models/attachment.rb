class Attachment < ActiveRecord::Base
    belongs_to :attachable, polymorphic: true 
	  belongs_to :referenceable, polymorphic: true 
	# belongs_to :bill
  	has_attached_file :attachment, styles: {thumb: "100x100"}
  	validates_attachment_content_type :attachment, content_type: ["image/jpeg", "image/jpg", "image/png", "application/pdf"]


  	def self.attachments_for_json_response(user)
  		attchmnt_arr = []
  	    user.attachments.where(referenceable_id: nil).each do |att|
  	    	attchmnt_arr << att.attributes.merge(url: att.attachment.url)
  	    end
  	    return attchmnt_arr
  	end
end
