class CustomersController < ApplicationController
  def index
    if params[:term].present?
      @customers = current_organization.customers.where("name ILIKE ?", "%#{params[:term]}%")
    else
      @customers = current_organization.customers.all
    end
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @customers.as_json(:only => [:id,:name]) }
      format.csv { send_data @customers.to_csv }
      format.xls { send_data @customers.to_csv(col_sep: "\t") }
      format.pdf {  render pdf: "customers", layout: 'pdf.html.erb' }
    end
  end

  def show
    @customer = current_organization.customers.find(params[:id])
    @invoices = @customer.invoices.includes(:invoice_payments)
    # customer_email = @customer.primary_contact.email
    # @emails = current_user.sent_invoice_emails.where(to_email: customer_email)
  end

  def new
    @customer = Customer.new
    @billing_address = Address.new
    @shipping_address = Address.new
  end

  def create
    @customer = current_organization.customers.new(customer_params)
    @customer.creator = current_user
    respond_to do |format|
      if @customer.save
        format.html { redirect_to customers_path }
        format.json { render json: @customer }
      else
        flash.now[:errors] = @customer.errors.full_messages
        @billing_address = @customer.billing_address
        @shipping_address = @customer.shipping_address
        format.json { render json: @customer.errors.full_messages, status: :unprocessable_entity }
        format.html { render :new }
      end
    end
  end

  def update
    @customer = current_organization.customers.find(params[:id])
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to customers_path }
        format.json { render json: @customer }
      else
        flash.now[:errors] = @customer.errors.full_messages
        @billing_address = @customer.billing_address
        @shipping_address = @customer.shipping_address
        format.json { render json: @customer.errors.full_messages, status: :unprocessable_entity }
        format.html { render :new }
      end
    end
  end

  def edit
    @customer = current_organization.customers.find(params[:id])
  end

  private

  def customer_params
    params
      .require(:customer)
      .permit(
        :name,
        :company_name,
        :parent_customer_id,
        :customer_type,
        :contact_id,
        :account_number,
        :payment_terms,
        :description,
        :customer_note,
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
