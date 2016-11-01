class InvoiceMailer < ApplicationMailer
  def reminder(invoice, sender)
    @customer = invoice.customer.primary_contact
    @invoice = invoice

    mail(to: @customer.email, from: sender.email, subject: 'A little reminder')
    @reminder = InvoiceReminder.create(invoice_id: invoice.id, sender_id: sender.id, sent_to: @customer.email, sent_at: Time.now)
  end

  def initial(params, file)
    if file.present?
      file.each do |name, path|
        attachments[name] = File.read(path)
      end
    end
    mail( to: params[:to], 
          cc: params[:cc], 
          bcc: params[:bcc], 
          from: params[:from], 
          subject: params[:subject], 
          body: params[:body] )
  end
end
