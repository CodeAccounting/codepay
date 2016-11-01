class SupportMailer < ApplicationMailer

	def support_mail(detail)
		name = detail[:name]
		contact_number = detail[:contact_number]
		email = detail[:email]
		message = detail[:message]

		mail(:to => 'sharma.paras4444@gmail.com', 
			 :from => "#{name} <#{email}>",
			 :subject => "From CodePaying Support Page",
   			 :body => "#{message} \n #{contact_number}" )
	end
end
