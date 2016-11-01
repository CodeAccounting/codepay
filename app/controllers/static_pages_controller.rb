class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!
  # skip_before_action :check_organization_user
  
  def welcome
    render :welcome, layout: false
  end

  def root
    if user_signed_in? 
      redirect_to "/dashboards/new"
    else
      redirect_to "/welcome"
    end
  end

  def search
  	keywords = params[:keywords]
  	if keywords.present?
  		@results = Customer.where("name ILIKE ?", "%#{keywords}%") + Vendor.where("name ILIKE ?", "%#{keywords}%")
  	else
  		@results = []
  	end
  end

  def contact_us
    
  end
end
