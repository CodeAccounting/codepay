class PayeesController < ApplicationController
  load_and_authorize_resource

  # GET /payees
  # GET /payees.json
  def index
    if params[:term].present?
      @payees = current_organization.payees.where("name ILIKE ?", "%#{params[:term]}%")
    else
      @payees = current_organization.payees.all
    end
    respond_to do |format|
      format.html { render :index }
      format.csv { send_data @payees.to_csv }
      format.json { render json: @payees.as_json(:only => [:id,:name]) }
      format.xls { send_data @payees.to_csv(col_sep: "\t") }
      format.pdf {  render pdf: "payees", layout: 'pdf.html.erb' }
    end
  end

  # GET /payees/1
  # GET /payees/1.json
  def show
    @payee = current_organization.payees.find(params[:id])
  end

  # GET /payees/new
  def new
    @payee = Payee.new
    @billing_address = Address.new
    @shipping_address = Address.new
  end

  # GET /payees/1/edit
  def edit
    @payee = current_organization.payees.find(params[:id])
  end

  # POST /payees
  # POST /payees.json
  def create
    @payee = current_organization.payees.new(payee_params)
    @payee.creator = current_user
    if @payee.save
      redirect_to payees_path
    else
      flash.now[:errors] = @payee.errors.full_messages
      @billing_address = @payee.billing_address
      @shipping_address = @payee.shipping_address
      render :new
    end
  end

  # PATCH/PUT /payees/1
  # PATCH/PUT /payees/1.json
  def update
    respond_to do |format|
      if @payee.update(payee_params)
        format.html { redirect_to @payee, notice: 'Payee was successfully updated.' }
        format.json { render :show, status: :ok, location: @payee }
      else
        format.html { render :edit }
        format.json { render json: @payee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payees/1
  # DELETE /payees/1.json
  def destroy
    @payee.destroy
    respond_to do |format|
      format.html { redirect_to payees_url, notice: 'Payee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def payee_params
    params
      .require(:payee)
      .permit(
        :name,
        :company_name,
        :parent_customer_id,
        :customer_type,
        :contact_id,
        :account_number,
        :payment_terms,
        :description,
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
