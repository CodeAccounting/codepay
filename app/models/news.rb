class News < ActiveRecord::Base
	validates(:subject,
		      :description, 
		      presence: true)	
end
