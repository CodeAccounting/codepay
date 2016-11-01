class PaymentMailer < ApplicationMailer

	def payment_alert(usr)
		@user=usr		
		mail(to: 'sahil.codegaragetech@gmail.com', subject: "CodePaying - Bill Pay Request")
	end
end