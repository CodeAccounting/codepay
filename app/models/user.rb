class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  audited
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable,
         :confirmable
  
 	validates :first_name, :last_name, presence: true

  has_many :created_invoices, class_name: 'Invoice', foreign_key: :creator_id
  has_many :created_bills, class_name: 'Bill', foreign_key: :creator_id
  has_many :created_locations, class_name: 'Location', foreign_key: :creator_id
  has_many :created_departments, class_name: 'Department', foreign_key: :creator_id
  has_many :created_terms, class_name: 'Term', foreign_key: :creator_id
  has_many :created_bank_accounts, class_name: 'BankAccount', foreign_key: :creator_id

  has_many :created_customers, class_name: 'Customer', foreign_key: :creator_id
  has_many :created_vendors, class_name: 'Vendor', foreign_key: :creator_id

  has_many :sent_invoice_reminders, class_name: 'InvoiceReminder', foreign_key: :sender_id
  has_many :sent_invoice_emails, class_name: 'InvoiceEmail', foreign_key: :sender_id

  has_many :relations
  has_many :admin_organizations, -> { where(:relations => {user_type: 'admin'}) }, through: :relations
  # has_many :user_organizations, -> { where.not(:relations => {user_type: 'admin'}) }, through: :relations
  has_many :user_organizations, -> { where(:relations => {user_type: 'normal'}) }, through: :relations
  has_many :all_organizations, through: :relations
  # has_many :all_organization_users, through: :organizations
  has_many :created_invoice_payments, class_name: 'InvoicePayment', foreign_key: :creator_id
  has_many :bill_approvals, class_name: 'BillApproval', foreign_key: :assigned_to
  has_many :attachments, as: :attachable 
  has_many :created_items, class_name: 'Item', foreign_key: :creator_id
  has_many :created_taxs, class_name: 'Tax', foreign_key: :creator_id
  has_many :approvals, class_name: 'Approval', foreign_key: :assigned_to
  has_many :created_chart_of_accounts, class_name: 'ChartOfAccount', foreign_key: :creator_id

  has_one :profile_image
  has_one :background_image 
  has_one :identification
  has_one :subscription
  has_many :created_notes, class_name: 'Note', foreign_key: :creator_id


  has_and_belongs_to_many :roles

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

  accepts_nested_attributes_for :profile_image, :reject_if => lambda { |t| t['file'].nil? }
  accepts_nested_attributes_for :background_image, :reject_if => lambda { |t| t['file'].nil? }
  accepts_nested_attributes_for :identification, :reject_if => lambda { |t| t['file'].nil? }
  accepts_nested_attributes_for :billing_address 
  accepts_nested_attributes_for :shipping_address


  def full_name
    "#{ first_name } #{ last_name }"
  end

  def is_admin?
    relations.find_by(user_id: id, user_type: 'admin').present?
  end

  def has_current_role?(role)
    relations.find_by(user_id: id,
                      organization_id: current_organization_id,
                      user_type: role.to_s).present?
  end

  def which_role?(org_id)
    relation = relations.find_by(user_id: id, organization_id: org_id)
    return relation.user_type    
  end
  
  def avatar 
    ProfileImage.find_or_create_by(user_id: id).file.url(:avatar)
  end
  
  def cover
    BackgroundImage.find_or_create_by(user_id: id).file.url(:cover) 
  end
  def idetity
    Idetification.find_or_create_by(user_id: id).file.url(:idetity)
  end

  def all_organization_users
    organization_ids = self.all_organizations.map(&:id).uniq
    users = User.joins(:relations).where(relations: {organization_id: organization_ids}).uniq
   
    return users 
  end

  def all_under_invoices
    user_ids = self.all_organization_users.map(&:id)
    invoices = Invoice.where(creator_id: user_ids)
    return invoices
  end

def all_under_bills
    user_ids = self.all_organization_users.map(&:id)
    bills = Bill.where(creator_id: user_ids)
    return bills
  end  

  def invite_old_user(inviter, opts={})
    UserMailer.invite_user(self, opts).deliver_now
    self.invited_by_id = inviter.id
  end 

end
