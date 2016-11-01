class InvoiceRemindersController < ApplicationController
  def new
  end

  def index
    @reminders = current_user.sent_invoice_reminders
    respond_to do |format|
      format.html { render :index }
      format.csv { send_data @reminders.to_csv }
      format.xls { send_data @reminders.to_csv(col_sep: "\t") }
      format.pdf { render pdf: "reminders", layout: 'pdf.html.erb' }
    end
  end

  def create
    if params[:id].present?
      ids = params[:id].values
      ids.each do |id|
        invoice = current_user.created_invoices.find(id)
        InvoiceMailer.reminder(invoice, current_user).deliver_later
      end
      redirect_to invoices_path, notice: "Reminders has been sent."
    else
      flash[:error] = 'Select atleast one invoice.'
      redirect_to :back
    end
  end
end
