# == Schema Information
#
# Table name: vendors
#
#  id                 :integer          not null, primary key
#  vendor_name        :string           not null
#  pay_to             :string           not null
#  company_name       :string           not null
#  vendor_type        :string
#  description        :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  payment_address_id :integer
#  primary_contact_id :integer
#  organization_id    :integer
#vendor_note

class Vendor < ActiveRecord::Base
  
  after_save :add_vendor_note, :if => lambda {|obj| obj.vendor_note.present? }
  attr_accessor :vendor_note

  validates(
    :name,
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
  has_many :notes, as: :noteable
  has_many :credits

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
      all.each do |vendor|
        csv << [
          vendor.id,
          vendor.account_number,
          vendor.name,
          vendor.primary_contact.email,
          vendor.description,
          vendor.created_at.strftime("%d %B %Y"),
          vendor.updated_at.strftime("%d %B %Y")
        ]
      end
    end
  end

  def add_vendor_note
     usr_id = self.creator.id
     org_id = self.organization.id
     self.notes.create(creator_id: usr_id, organization_id: org_id, body: vendor_note)
  end

end
