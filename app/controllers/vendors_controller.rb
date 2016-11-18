class VendorsController < ApplicationController
def index
    if params[:term].present?
      @vvendor = current_organization.vendors.where("name ILIKE ?", "%#{params[:term]}%")
    else
      @vendors = current_organization.vendors.all
    end
    respond_to do |format|
      format.html { render :index }
      format.csv { send_data @vendors.to_csv }
      format.json { render json: @vendors.as_json(:only => [:id,:name]) }
      format.xls { send_data @vendors.to_csv(col_sep: "\t") }
      format.pdf {  render pdf: "vendors", layout: 'pdf.html.erb' }
    end
  end

  # GET /vendors/1
  # GET /vendors/1.json
  def show
    @vendor = current_organization.vendors.find(params[:id])
    @vendor_bills = @vendor.bills
  end

  # GET /vendors/new
  def new
    @vendor = Vendor.new
    @billing_address = Address.new
    @shipping_address = Address.new
  end

  # GET /vendors/1/edit
  def edit
    @vendor = current_organization.vendors.find(params[:id])
  end

  # POST /vendors
  # POST /vendors.json
  def create
    @vendor = current_organization.vendors.new(vendor_params)
    @vendor.creator = current_user
     respond_to do |format|
      if @vendor.save
        format.html { redirect_to vendors_path }
        format.json { render json: @vendor }
      else
        flash.now[:errors] = @vendor.errors.full_messages
        @billing_address = @vendor.billing_address
        @shipping_address = @vendor.shipping_address
        format.json { render json: @vendor.errors.full_messages, status: :unprocessable_entity }
        format.html { render :new }
      end
    end
    # if @vendor.save
    #   redirect_to vendors_path
    # else
    #   flash.now[:errors] = @vendor.errors.full_messages
    #   @billing_address = @vendor.billing_address
    #   @shipping_address = @vendor.shipping_address
     
    # end
  end

  # PATCH/PUT /vendors/1
  # PATCH/PUT /vendors/1.json
  def update 
     @vendor = Vendor.find(params[:id]) 
    if @vendor.update(vendor_params)
       redirect_to vendor_path
    else 
      flash[:errors] = @vendor.errors.full_messages
      redirect_to :back
    end
    # respond_to do |format| 
      
    #   if @vendor.update(vendor_params)

    #     format.html { redirect_to @vendor, notice: 'Vendor was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @vendor }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @vendor.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /vendors/1
  # DELETE /vendors/1.json
  def destroy
    @vendor.destroy
    respond_to do |format|
      format.html { redirect_to vendors_url, notice: 'Vendor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def show_attachments
      vendor = current_organization.vendors.find(params[:id])
      @vendor_bills = vendor.bills
  end

  # def vendors_list_by_ajax
  #     @vendors = Vendor.where("name ILIKE ?","%#{params[:name_startsWith]}%").first(10)
  #     respond_to do |format|
  #       format.json {render json: @bills.to_json}
  #     end
  # end

  def bills_list_by_ajax
      if params[:vendor_id].present?
          vendor = current_organization.vendors.find(params[:vendor_id])
          @bills = vendor.bills
          respond_to do |format|
           format.json {render json: @bills.to_json}
          end 
      end  
  end  

  private
    def vendor_params
    params
      .require(:vendor)
      .permit(
        :name, 
        :company_name,
        :parent_vendor_id,
        :customer_type,
        :contact_id,
        :account_number,
        :payment_terms,
        :description,
        :vendor_note,
        billing_address_attributes: [
          :address1,
          :address2,
          :city,
          :state,
          :zip,
          :country
        ],
        shipping_address_attributes: [
          :address1,
          :address2,
          :city,
          :state,
          :zip,
          :country
        ]
      )
  end
end
