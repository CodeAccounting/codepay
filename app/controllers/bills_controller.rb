class BillsController < ApplicationController
  before_action :set_bill, only: [:show, :edit, :update, :destroy]

  def index
    @bills = current_organization.bills
    respond_to do |format|
      format.html { render :index }
      format.csv { send_data @bills.to_csv }
      format.xls { send_data @bills.to_csv(col_sep: "\t") }
      format.pdf {  render pdf: "bills", layout: 'pdf.html.erb' }
    end
  end

  def show
    @bill = current_organization.bills.find(params[:id])
    @bill_attachment = @bill.attachment
    respond_to do |format|
      format.html { render :show }
      format.pdf {  render pdf: "bill", layout: 'pdf.html.erb' }
    end
  end

  def new
    @items = current_user.created_items.where(item_of: "Bill")
    if params[:attachment_id].present?
      @attachment = current_user.attachments.find(params[:attachment_id])
    end  
    @bill = current_user.created_bills.new
    @locations = current_user.created_locations
    @terms = current_user.created_terms
    @departments = current_user.created_departments
    @taxs = current_user.created_taxs.where(tax_of: "Bill")
    @chart_of_accounts = current_user.created_chart_of_accounts
  end

  def copy_bill
    @bill = current_user.all_under_bills.find(params[:id])
    @terms = current_user.created_terms
    @locations = current_user.created_locations
    @departments = current_user.created_departments
    render :new
  end

  def edit  
      if @bill.approvals.present? 
      # @bill = current_organization.bills.find(params[:id])
        if @bill.status_check != "Pending"
          @locations = current_user.created_locations
          @terms = current_user.created_terms
          @departments = current_user.created_departments
          @items = current_user.created_items.where(item_of: "Bill")
          @taxs = current_user.created_taxs.where(tax_of: "Bill")
          @chart_of_accounts = current_user.created_chart_of_accounts
        else
          flash[:errors] = ["You can't edit this bill yet, As bill has been sent for approval"]
          redirect_to :back
        end  
      else
        @locations = current_user.created_locations
        @terms = current_user.created_terms
        @departments = current_user.created_departments
        @items = current_user.created_items.where(item_of: "Bill")
        @taxs = current_user.created_taxs.where(tax_of: "Bill")
        @chart_of_accounts = current_user.created_chart_of_accounts
      end  
  end

  def create
      @bill = current_user.created_bills.new(bill_params)
      @bill.organization = current_organization
    if @bill.save
      choice = params[:preview].present? ? true : false
        if params[:attachment_id].present?
            attachment = current_user.attachments.find(params[:attachment_id])
            attachment.referenceable = @bill
            attachment.save
        end 
      redirect_to bills_path(bill_id: @bill.id, preview: choice)
    else
      @locations = current_user.created_locations
      @terms = current_user.created_terms
      @departments = current_user.created_departments
      flash[:errors] = @bill.errors.full_messages
      if params[:attachment_id].present?  
        redirect_to new_bill_path(:attachment_id => params[:attachment_id])
      else
        redirect_to new_bill_path
      end  
    end
  end

  def update
      if @bill.update_attributes(bill_params)
         redirect_to bill_path(@bill) 
      else
       flash[:errors] = @bill.errors.full_messages
      end  
  end

  def bill_preview
      if params[:bill][:vendor_id].present?
        vendor = Vendor.find(params[:bill][:vendor_id])
        location = Location.find(params[:bill][:location_id])
        payment_term = Term.find(params[:bill][:payment_term_id])
        department = Department.find(params[:bill][:department_id])
        @vendor_name = vendor.try(:name)
        @location = location.try(:name)
        @payment_term = payment_term.try(:name)
        @department = department.try(:name)
      end  
      @values = params[:bill]
      respond_to do |format|
      format.pdf { render pdf: "bill_preview", layout: 'pdf.html.erb'}
      end
  end

  def bill_show
    @approval = Approval.find_by(id: params[:approval_id], approvable_id: params[:id])
    if @approval.present? && @approval.status == "Cancelled"
      @bill = current_organization.bills.find(params[:id])
    else
      redirect_to new_dashboard_path
    end  
  end

  def approval_request_again
      approval = Approval.find(params[:id])
      if approval.status == "Cancelled" && approval.assigner == current_user
         approval.update_attributes(status: "Pending")
         redirect_to new_dashboard_path
      else
         redirect_to new_dashboard_path
      end   
  end

  private
    def set_bill
      
      @bill = current_user.created_bills.find(params[:id])

    end

    def bill_params
      params.require(:bill).permit(
        :vendor_id,
        :bill_number,
        :bill_date,
        :due_date,
        :due_amount,
        :payment_term_id,
        :location_id,
        :department_id,
        :bill_template_id,
        :po_number,
        :sales_rep,
        :message,
        :bill_note,
        :assigned_to_ids=>[],
        bill_items_attributes: [  :id,
                                  :item_id,
                                  :description,
                                  :quantity,
                                  :price,
                                  :location_id,
                                  :tax_id,
                                  :amount,
                                  :_destroy]
        )
    end
end
