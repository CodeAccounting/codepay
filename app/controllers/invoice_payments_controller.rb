class InvoicePaymentsController < ApplicationController
  def index
    @invoice_payments = InvoicePayment.includes(:invoices)
  end

  def create
  	  invoice_payment = current_user.created_invoice_payments.new(invoice_payment_params)
      invoice_payment.organization = current_organization
      invoices = current_user.created_invoices.where(:id => params[:invoice_id])
  	if invoice_payment.save
       invoice_payment.invoices << invoices
       invoice_payment.update_invoice_status

      redirect_to new_invoice_payment_path
    else  
  	  flash[:errors] = invoice_payment.errors.full_messages
  	  redirect_to new_invoice_payment_path
    end  
  end

  def new
  end

  def show
    @invoice_payment = InvoicePayment.find(params[:id])
  end

  def on_change
      if params[:customer_id].present?
          customer = current_user.created_customers.find(params[:customer_id])
          @invoices = customer.invoices.where(received: false)
          respond_to do |format|
           format.json {render json: @invoices.to_json}
          end 
      end  
  end  

  private
  	def invoice_payment_params
  		params.require(:invoice_payment).permit(:date,
                :payment_method, 
		  					:payment_account, 
  							:reference, 
  							:payment_amount, 
  							:message 
  							)

   end
end
