class OrganizationsController < ApplicationController
  load_and_authorize_resource
  before_filter :is_an_admin?
  before_filter :get_organization, only: [:edit, :show, :update]

  def index
    @organizations = current_user.all_organizations
  	@users = current_organization.all_organization_users
  end

  def new
    @organization = current_user.all_organizations.new
  end

  def edit
  end

  def update
    if @organization.update(organization_params)
      redirect_to organization_path(@organization)
    else
      flash.now[:errors] = @organization.errors.full_messages
      render :edit
    end
  end

  def create
  	@organization = current_user.all_organizations.new(organization_params)
  	if @organization.save
  		current_user.relations.create(organization_id: @organization.id, user_type: 'admin')
  		redirect_to organizations_path
  	else
  		flash.now[:errors] = @organization.errors.full_messages
      render :new
  	end
  end

  def show
    @users = @organization.all_organization_users
  end

  private

  def get_organization
    @organization = current_user.all_organizations.find(params[:id])
  end

  def organization_params
  	params.require(:organization).permit( :name, 
                                          :organization_type, 
                                          :accounting_software,
                                          attachment_attributes: [:id, :attachment])
  end

  def is_an_admin?
    redirect_to root_path unless current_user.is_admin?
  end
end
