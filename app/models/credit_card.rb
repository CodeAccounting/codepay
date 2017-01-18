class CreditCard < ActiveRecord::Base
	
	belongs_to :organization
	belongs_to :creator, class_name: 'User', foreign_key: :creator_id


	validates(
    :card_number,
    :expiration_date,
    :cvv_code,
    :card_type,
    :billing_zip_code,
    :name,
    presence: true
    )
end
