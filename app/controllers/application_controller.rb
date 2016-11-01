class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  helper_method :current_organization
  before_filter :configure_permitted_parameters, if: :devise_controller?
  # before_filter :check_organization_user, unless: :devise_controller?
  # before_filter :check_master  
  # before_filter :subscription, if: :user_signed_in?
  

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def current_organization
    unless current_user.current_organization_id.present?
      orgID = current_user.all_organizations.first.id
      current_user.update_attributes(current_organization_id: orgID)
    end
    current_user.all_organizations.find(current_user.current_organization_id)
  end

  def check_bank_accounts
      if !current_user.created_bank_accounts.present?
        flash[:notice] = "You Must Create a Bank Account"     
        redirect_to bank_accounts_path
      end

  end

  def subscription
    if current_user.subscription.present?
      if current_user.subscription.status == "canceled"
        flash[:notice] = "You Must Subscribe First"
        redirect_to new_subscription_path
      end  
    else
      flash[:notice] = "You Must Subscribe First"
      redirect_to new_subscription_path
    end  
  end

  # def check_organization_user
  #     redirect_to "/admin" unless current_user.user_organizations.present?
  # end
  
  protected

  def configure_permitted_parameters
    # Only add some parameters
    # devise_parameter_sanitizer.for(:accept_invitation).concat [:first_name, :last_name]
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:first_name, :last_name])
    # Override accepted parameters
    # devise_parameter_sanitizer.for(:accept_invitation) do |u|
    #   u.permit(:first_name, :last_name, :phone, :password, :password_confirmation,
    #            :invitation_token)
    # end
  end

end
