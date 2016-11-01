class InvoiceEmailsController < ApplicationController
  def new
  end

  def index
    @emails = current_user.sent_invoice_emails
    respond_to do |format|
      format.html { render :index }
      format.csv { send_data @emails.to_csv }
      format.xls { send_data @emails.to_csv(col_sep: "\t") }
      format.pdf { render pdf: "emails", layout: 'pdf.html.erb' }
    end
  end

  def show
    @email = current_user.sent_invoice_emails.find(params[:id])
  end
end
