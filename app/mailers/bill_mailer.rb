class BillMailer < ApplicationMailer
	def reminder(bill)
    @customer = bill.creator
    @bill = bill

    mail(to: @customer.email, subject: 'A little reminder')
  end
end
