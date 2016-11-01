class Payee < ActiveRecord::Base
	validates(
    :name,
    :primary_contact,
    :account_number,
    :billing_address,
    presence: true
  )

  belongs_to(
    :billing_address,
    class_name: 'Address',
    foreign_key: :billing_address_id
  )
  belongs_to(
    :shipping_address,
    class_name: 'Address',
    foreign_key: :shipping_address_id
  )

  belongs_to :creator, class_name: 'User'
  belongs_to :organization
  belongs_to :primary_contact, class_name: 'Contact', foreign_key: :contact_id
	has_many :bills

  accepts_nested_attributes_for :billing_address
  accepts_nested_attributes_for :shipping_address

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << [
        "id",
        "account_number",
        "name",
        "primary contact",
        "description",
        "created_at",
        "updated_at",
      ]
      all.each do |payee|
        csv << [
          payee.id,
          payee.account_number,
          payee.name,
          payee.primary_contact.email,
          payee.description,
          payee.created_at.strftime("%d %B %Y"),
          payee.updated_at.strftime("%d %B %Y")
        ]
      end
    end
  end
end
