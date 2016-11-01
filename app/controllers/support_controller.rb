class SupportController < ApplicationController

	 def index
	 end

	 def create
	 	detail = params[:contactDetail]
	 	SupportMailer.support_mail(detail).deliver_now
	 	redirect_to support_index_path
	 end
end
