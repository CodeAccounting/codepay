class UsersController < ApplicationController

  skip_before_filter :check_organization_user, only: :change_admin_organization

  def show
  	@user = current_user
  end

  def edit
  	@user = current_user
    @billing_address = current_user.billing_address
    @shipping_address = current_user.shipping_address
  end

  def update 
 
  	@user = current_user
  	if params[:user][:password].present? or params[:user][:password_confirmation].present?
  		
      if @user.update_with_password(user_params)
  			sign_in @user, :bypass => true
  			redirect_to @user
  		else
	      flash[:errors] = @user.errors.full_messages
	      redirect_to edit_profile_path(@user)
	    end
    else 
    	params[:user].delete(:current_password)
    	if @user.update_without_password(user_params)
      	redirect_to @user  
      else
	      flash[:errors] = @user.errors.full_messages
	      redirect_to edit_profile_path(@user)
	    end
    end
  end
  
  def change_organization
    organization = current_user.all_organizations.find(params[:organization_id])
    current_user.update_attributes(current_organization_id: organization.id)
    flash[:notice] = "You are now active for '#{organization.name}'."
    redirect_to root_path
  end

  # def change_user_organization
  #   organization = current_user.user_organizations.find(params[:organization_id])
  #   current_user.update_attributes(current_organization_id: organization.id)
  #   flash[:notice] = "You are now active for '#{organization.name}'."
  #   redirect_to root_path
  # end

  def change_admin_organization
    organization = current_user.admin_organizations.find(params[:organization_id])
    current_user.update_attributes(current_admin_organization_id: organization.id)
    flash[:notice] = "You are now active for '#{organization.name}'."
    redirect_to "/admin"
  end

  private 

  	 def user_params
      
    params.require(:user).permit(:first_name, :last_name, :title, :current_password,
    															:password, :password_confirmation, 
                                  :email, :date_of_birth,
                                  profile_image_attributes: [:id, :file],
                                  background_image_attributes: [:id, :file],
                                  identification_attributes: [:id, :doc_type, :file],
                                  billing_address_attributes: [
                                      :id,
                                      :address1,
                                      :address2,
                                      :city,
                                      :state,
                                      :zip,
                                      :country
                                    ],
                                    shipping_address_attributes: [
                                      :id,
                                      :address1,
                                      :address2,
                                      :city,
                                      :state, 
                                      :zip,
                                      :country
                                    ])
  end

end
