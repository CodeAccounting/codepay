class Admin::OrganizationUsersController < Admin::ApplicationController
	load_and_authorize_resource :except => [:show, :edit, :update]
  before_filter :get_user, only: [:show, :edit, :update]
  def index
  	@users = current_organization.all_organization_users
  end

  def new
  	@organizations = current_user.all_organizations
  end

  def create
    if params[:email].present?
      
      u = User.find_by_email(params[:email])
        if u.present?
          relation = u.relations.new(organization_id: current_organization.id, user_type: params[:role_name])
            if relation.save
                u.invite_old_user(current_user, {role: params[:role_name], org: current_organization.name})
                u.update_attributes(invited_for_id: current_organization.id)
            else
                flash[:errors] = relation.errors.full_messages
                redirect_to new_organization_user_path and return
            end
                redirect_to admin_organization_users_path 
        else
    	     user = User.invite!({ first_name: "", 
                            last_name: "", 
                            email: params[:email],
                            current_organization_id: current_organization.id,
                            invited_for_id: current_organization.id}, current_user,
                            {role:  params[:role_name], org: current_organization.name})
    	     user.relations.create(organization_id: current_organization.id, user_type: params[:role_name])

    	     redirect_to admin_organization_users_path
        end
    else 
    flash[:errors] = ["Please enter email address"]
    redirect_to new_organization_user_path 
    end
end
  def update
    relation = @user.relations.find_by(organization_id: current_organization.id)
    relation.update_attributes(user_type: params[:role])
    respond_to do |format|
      format.html { redirect_to admin_organization_users_path }
      format.json { render :text => "success" }
    end
  end

  def edit
  end

  def show
    @organizations = @user.all_organizations
  end

  # def csv_download
  #   debugger
  # end

  private

  def get_user
     @user = current_user.all_organization_users.find(params[:id])
  end
end