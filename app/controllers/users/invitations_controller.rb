class Users::InvitationsController < Devise::InvitationsController
  layout "before_login"
  def edit
    @user = resource
    super
  end

  def update
    self.resource = resource_class.accept_invitation!(update_resource_params)

    if resource.errors.empty?
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active                                                                                        
      set_flash_message :notice, flash_message
      sign_in(resource_name, resource)
      respond_with resource, :location => after_accept_path_for(resource)
    else
      respond_with_navigational(resource){ render :edit }
    end
  end
  private


  # this is called when creating invitation
  # should return an instance of resource class
  def invite_resource
    ## skip sending emails on invite
    # super do |u|
    #   u.skip_invitation = true
    # end
  end

  # this is called when accepting invitation
  # should return an instance of resource class
  def accept_resource
    # resource = resource_class.accept_invitation!(update_resource_params)
    # ## Report accepting invitation to analytics
    # Analytics.report('invite.accept', resource.id)
    # resource
  end
end