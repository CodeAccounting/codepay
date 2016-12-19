class IntegrationsController < ApplicationController

	before_action :set_vendor_create_qb_service, only: [:create, :edit, :update, :destroy]
	def index
		if session[:token].present? && params[:fetch] == "vendors"
			oauth_client = OAuth::AccessToken.new($qb_oauth_consumer, session[:token], session[:secret])
			@vendor_service = Quickbooks::Service::Vendor.new 
			@vendor_service.access_token = oauth_client
      		@vendor_service.realm_id = session[:realm_id]
      		@vendors = @vendor_service.all
      		# @vendors = vendors.entries
		elsif session[:token].present? && params[:fetch] == "bills"
			oauth_client = OAuth::AccessToken.new($qb_oauth_consumer, session[:token], session[:secret])
			@bill_service = Quickbooks::Service::Bill.new 
			@bill_service.access_token = oauth_client
      		@bill_service.realm_id = session[:realm_id]
      		@bills = @bill_service.all
		end
	end

	def new
		
	end

	def create
		vendor = Quickbooks::Model::Vendor.new
		vendor.given_name = vendor_params[:name]
		vendor.email_address = vendor_params[:email]
		@vendor_service.create(vendor)
		redirect_to	integrations_path		
	end

	def authenticate
	    callback = oauth_callback_url
	    token = $qb_oauth_consumer.get_request_token(:oauth_callback => callback)
	    session[:qb_request_token] = Marshal.dump(token)
	    # session[:qb_request_token] = token
	    # If Rails >= 4.1 you need to do this => session[:qb_request_token] = Marshal.dump(token)
	    redirect_to("https://appcenter.intuit.com/Connect/Begin?oauth_token=#{token.token}") and return
  	end

  	def oauth_callback
	    at = Marshal.load(session[:qb_request_token]).get_access_token(:oauth_verifier => params[:oauth_verifier])
	    # at = session[:qb_request_token].get_access_token(:oauth_verifier => params[:oauth_verifier])
	    # If Rails >= 4.1 you need to do this =>  at = Marshal.load(session[:qb_request_token]).get_access_token(:oauth_verifier => params[:oauth_verifier])
	    session[:token] = at.token
	    session[:secret] = at.secret
	    session[:realm_id] = params['realmId']
	    flash.notice = "Your QuickBooks account has been successfully linked."
	    @url = integrations_path
    	render 'close_and_redirect', layout: false
  	end

  	def disconnect
	    set_qb_service('AccessToken')
	    result = @service.disconnect
	    if result.error_code == '270'
	      msg = 'Disconnect failed as OAuth token is invalid. Try connecting again.'
	    else
	      msg = 'Successfully disconnected from QuickBooks'
	    end
	    session[:token] = nil
	    session[:secret] = nil
	    session[:realm_id] = nil
	    redirect_to integrations_path, notice: msg
  	end

  	private

  	def vendor_params
  		params.require(:integration).permit(
        :name,
        :email)
  	end
  	
  	def set_vendor_create_qb_service
      oauth_client = OAuth::AccessToken.new($qb_oauth_consumer, session[:token], session[:secret])
      @vendor_service = Quickbooks::Service::Vendor.new
      @vendor_service.access_token = oauth_client
      @vendor_service.realm_id = session[:realm_id]
    end
end
