# == Schema Information
#
# Table name: organizations
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Organization < ActiveRecord::Base
  
  has_many :users
  has_associated_audits

  validates :name, presence: true


  has_many :relations
  has_many :organization_admins, -> { where(:relations => {user_type: 'admin'}) }, through: :relations
  has_many :organization_users, -> { where(:relations => {user_type: 'normal'}) }, through: :relations
  has_many :all_organization_users, through: :relations


  has_many :customers
  has_many :vendors
  has_many :contacts
  has_many :invoices
  has_many :bills
  has_many :bank_accounts 
  has_many :invoice_payments
  has_many :items
  has_many :taxs
  has_many :chart_of_accounts
  has_many :notes
  has_many :attachments
  has_many :credits
  has_many :bill_informations

  has_one  :attachment, as: :attachable
  accepts_nested_attributes_for :attachment, :reject_if => lambda { |t| t['attachment'].nil? }

  # def all_organization_users
  # 	users = User.joins(:relations).where(relations: {organization_id: self.id}).uniq
  #   return users
  # end

def all_under_invoices
    user_ids = self.all_organization_users.map(&:id)
    invoices = Invoice.where(organization_id: user_ids)
    return invoices
  end

end

