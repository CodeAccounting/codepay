class BankAccount < ActiveRecord::Base
	
	validates(
    :account_number,
	:bank_name,
    presence: true
  	)

	belongs_to :organization
	belongs_to :creator, class_name: 'User'
end
