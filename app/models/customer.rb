# == Schema Information
#
# Table name: customers
#
#  id                  :integer          not null, primary key
#  name                :string           not null
#  company_name        :string
#  parent_customer_id  :integer
#  customer_type       :string
#  contact_id          :integer          not null
#  account_number      :string           not null
#  payment_terms       :string
#  description         :string
#  billing_address_id  :integer          not null
#  shipping_address_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  organization_id     :integer
#  primary_contact_id  :integer
#

class Customer < ActiveRecord::Base
  
  after_save :add_customer_note, :if => lambda {|obj| obj.customer_note.present? }
  attr_accessor :customer_note

  validates(
    :name,
    presence: true, uniqueness: true 
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
  has_many :invoices
  has_many :notes, as: :noteable

  belongs_to :creator, class_name: 'User'
  belongs_to :organization
  belongs_to :primary_contact, class_name: 'Contact', foreign_key: :contact_id

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
      all.each do |customer|
        csv << [
          customer.id,
          customer.account_number,
          customer.name,
          customer.primary_contact.email,
          customer.description,
          customer.created_at.strftime("%d %B %Y"),
          customer.updated_at.strftime("%d %B %Y")
        ]
      end
    end
  end

  def add_customer_note
     usr_id = self.creator.id
     org_id = self.organization.id
     self.notes.create(creator_id: usr_id, organization_id: org_id, body: customer_note)
  end
end
