class Admins::ApplicationController < ActionController::Base
	layout 'admin'

	before_filter :authenticate_admin!,:current_ability
	# before_filter :check_organization_admin
	# before_filter :check_is_master
	helper_method :current_organization

	rescue_from CanCan::AccessDenied do |exception|
		flash[:error] = exception.message
	    redirect_to admins_dashboards_path
	end

	# def check_organization_admin
 #     	redirect_to root_path unless current_user.is_admin?
 #  	end

 	def check_is_master
     	redirect_to root_path unless current_user.is_master
  	end

  
  	def current_organization
	    unless current_user.current_admin_organization_id.present?
	      orgID = current_user.admin_organizations.first.id
	      current_user.update_attributes(current_admin_organization_id: orgID)
	    end
	    current_user.admin_organizations.find(current_user.current_admin_organization_id)
  	end

  	private
  	def current_ability
	  # if admin_signed_in?
	    @current_ability ||= AdminAbility.new(current_admin)
	  # else
	    # @current_ability ||= Ability.new(current_user)
	  # end
	end
end
