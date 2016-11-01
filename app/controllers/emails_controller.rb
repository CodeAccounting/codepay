class EmailsController < ApplicationController
  protect_from_forgery with: :null_session
  
  def new
    invoice = current_user.all_under_invoices.find(params[:invoice_id])
    @customer = invoice.customer.primary_contact
    @invoice = invoice
  end

  def create
    data = { id: params[:id],
             from: params[:from],
             cc: (params[:cc] || ""), 
             bcc: (params[:bcc] || ""),
             to: params[:to],
             subject: params[:subject],
             body: params[:body] }
    object = record_email(data)
    redirect_to invoice_emails_path, notice: "An invoice email has been created with id #{object.id}"
  end

  def send_mail
    record  = current_user.sent_invoice_emails.find(params[:record_id])
    if params[:attachments].present?
      file = {}
      params[:attachments].each do |attach|
        name = attach.original_filename
        path = attach.path
        file[name] = path
      end
    end
    data = { id: record.invoice_id,
             from: params[:from],
             cc: (params[:cc] || ""), 
             bcc: (params[:bcc] || ""),
             to: params[:to],
             subject: params[:subject],
             body: params[:body] }
    details = InvoiceMailer.initial(data, file).deliver_now
    record.update_attributes(message_id: details.message_id)
    redirect_to invoice_emails_path, notice: "An invoice email has been sent"
  end

  def update
    params["_json"].each do |response|
      if response["smtp-id"].present?
        msg_id = response["smtp-id"].delete('<>')
        object = InvoiceEmail.find_by_message_id(msg_id)
        object.update_attributes(sg_message_id: response["sg_message_id"])
      end
      object = InvoiceEmail.find_by_sg_message_id(response["sg_message_id"])
      if object.present?
        event = response[:event]
        object.update_attributes(status: event) 
      end
    end
    render :json => { "message" => "RIGHT" }, :status => 200
  end

  private
   def record_email(data)
     current_user.sent_invoice_emails.create!( invoice_id: data[:id],
                                              to_email: data[:to],
                                              cc: data[:cc], 
                                              bcc: data[:bcc],
                                              from_email: data[:from],
                                              subject: data[:subject],
                                              raw_content: data[:body],
                                              status: "created" )
   end
end
