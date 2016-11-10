class Bill < ActiveRecord::Base
	# validates :vendor_id, :due_date, :invoice_date, :creator_id, presence: true
  # after_save :set_assigned_to_id, :reject_if => lambda { |t| t.assigned_to_ids.nil? }
  after_save :set_assigned_to_id, :if => lambda {|obj| obj.assigned_to_ids.present? }
  after_save :add_bill_note, :if => lambda {|obj| obj.bill_note.present? }
             

  attr_accessor :assigned_to_ids, :bill_note 

  audited associated_with: :organization
  acts_as_paranoid 
  
  validates(
    :creator_id,
    :vendor_id,
    :bill_number,
    :bill_date,
    :due_date,
    presence: true
    )
	belongs_to :vendor, class_name: 'Vendor'
	belongs_to :creator, class_name: 'User'
  belongs_to :location, class_name: 'Location'
  belongs_to :department, class_name: 'Department'
  belongs_to :payment_term, class_name: 'Term'
  belongs_to :organization
  
  has_one    :bill_information, dependent: :destroy
  has_one    :attachment, as: :referenceable

  has_many   :bill_approvals
  has_many   :bill_items
  has_many   :approvals, as: :approvable
  has_many   :notes, as: :noteable

  accepts_nested_attributes_for :bill_items
  

	def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << [
        "id",
        "vendor_name",
        "bill_number",
        "bill_date",
        "due_date",
        "due_amount",
        "payment_terms",
        "location",
        "department",
        "po_number",
        "sales_rep",
        "message",
        "created_at",
        "updated_at",
      ]
      all.each do |bill|
        csv << [
          bill.id,
          bill.vendor.name,
          bill.bill_date.strftime("%d %B %Y"),
          bill.due_date.strftime("%d %B %Y"),
          bill.due_amount,
          bill.payment_term.try(:name),
          bill.location.try(:name),
          bill.department.try(:name),
          bill.po_number,
          bill.sales_rep,
          bill.message,
          bill.created_at.strftime("%d %B %Y"),
          bill.updated_at.strftime("%d %B %Y")
        ]
      end
    end
  end

  def status_check
    status_array = self.approvals.map(&:status).uniq 
    if status_array.length == 1
        if status_array[0] == "Approved"
          "Approved"
        else 
        (status_array[0] == "Pending") ? "Pending" : "Cancelled"
        end        
    else status_array.length > 1
        if status_array.include?("Pending")
          "Pending"
        else    
           "Cancelled" 
        end     
    end       
  end

  def set_assigned_to_id
      user_id = self.creator.id
      assigned_to_ids.each do |assigned_to_id|
        self.approvals.create(:assigned_by => user_id, :assigned_to => assigned_to_id)
      end  
  end

  def add_bill_note
     usr_id = self.creator.id
     org_id = self.organization.id
     self.notes.create(creator_id: usr_id, organization_id: org_id, body: bill_note)
  end

end
