class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:pdf_items, :show, :edit, :update]
  load_and_authorize_resource

  def new
    @invoice = current_user.all_under_invoices.new
    if params[:attachment_id].present?
      @attachment = current_user.attachments.find(params[:attachment_id])
    end  
    @terms = current_user.created_terms
    @locations = current_user.created_locations
    @departments = current_user.created_departments
    @items = current_user.created_items.where(item_of: "Invoice") 
    @taxs = current_user.created_taxs.where(tax_of: "Invoice") 
    @chart_of_accounts = current_user.created_chart_of_accounts
  end

  def copy_invoice
    @invoice = current_user.all_under_invoices.find(params[:id])
    @terms = current_user.created_terms
    @locations = current_user.created_locations
    @departments = current_user.created_departments
    render :new
  end

  def create
    @invoice = current_user.created_invoices.new(invoice_params)
    @invoice.organization = current_organization
    if @invoice.save
      choice = params[:preview].present? ? true : false
        if params[:attachment_id].present?
            attachment = current_user.attachments.find(params[:attachment_id])
            attachment.referenceable = @invoice
            attachment.save
        end
      redirect_to invoices_path(invoice_id: @invoice.id, preview: choice)
    else
      @terms = current_user.created_terms
      @locations = current_user.created_locations
      @departments = current_user.created_departments
      flash[:errors] = @invoice.errors.full_messages
      if params[:attachment_id].present?  
        redirect_to new_invoice_path(:attachment_id => params[:attachment_id])
      else
        redirect_to new_invoice_path
      end
    end
  end

  def show
    @invoice_attachment = @invoice.attachment
    respond_to do |format|
      format.html { render :show }
      format.pdf {  render pdf: "invoice", layout: 'pdf.html.erb' }
    end
  end

  def destroy
    @invoice = current_user.all_under_invoices.find(params[:id])
    @invoice.destroy
    redirect_to invoices_path, notice: "Invoice has been voided!"
  end

  def restore
    @invoice = current_user.all_under_invoices.only_deleted.find(params[:id])
    @invoice.restore
    redirect_to invoices_path, notice: "Invoice has been restored!"
  end

  def index
    @invoices = current_organization.invoices
    @with_deleted = current_organization.invoices.with_deleted
    respond_to do |format|
      format.html { render :index }
      format.csv { send_data @invoices.to_csv }
      format.xls { send_data @invoices.to_csv(col_sep: "\t") }
      format.pdf {  render pdf: "invoices", layout: 'pdf.html.erb' }
    end
  end

  def edit
  end

  def update
    if @invoice.update(invoice_params)
      redirect_to @invoice
    else
      flash.now[:errors] = @invoice.errors.full_messages
      render :edit
    end
  end

  def pdf_items

    @items = params[:items]
    respond_to do |format|
      format.pdf { render pdf: "pdf_items", layout: 'pdf.html.erb' }
    end
  end

  def invoice_preview
      if params[:invoice][:customer_id].present?
        customer = Customer.find(params[:invoice][:customer_id])
        location = Location.find(params[:invoice][:location_id])
        payment_term = Term.find(params[:invoice][:payment_term_id])
        department = Department.find(params[:invoice][:department_id])
        @customer_name = customer.try(:name)
        @location = location.try(:name)
        @payment_term = payment_term.try(:name)
        @department = department.try(:name)
      end  
      @values = params[:invoice]
      respond_to do |format|
      format.pdf { render pdf: "invoice", layout: 'pdf.html.erb'}
      end
  end

  private

    def set_invoice
     @invoice = current_organization.invoices.find(params[:id])
    end

    def invoice_params
      params.require(:invoice)
      .permit(
        :customer_id,
        :invoice_number,
        :invoice_date,
        :due_date,
        :due_amount,
        :payment_term_id,
        :location_id,
        :department_id,
        :invoice_template_id,
        :po_number,
        :sales_rep,
        :message,
        :invoice_note,
        :assigned_to_ids=>[],
        invoice_items_attributes: [ :id,
                                    :item_id,
                                    :description,
                                    :chart_of_account_id,
                                    :quantity,
                                    :price,
                                    :location_id,
                                    :tax_id,
                                    :amount]
        )
    end
end
