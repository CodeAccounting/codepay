class SettingsController < ApplicationController

  # GET /settings/1/edit
  def index
     
  end
  def edit_profile
    @user = current_user
    @billing_address = current_user.billing_address
    @shipping_address = current_user.shipping_address
  end  

  def edit_payment_account
  end

  def edit_software_integration
  end

end
