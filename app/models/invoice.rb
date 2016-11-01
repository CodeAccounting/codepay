# == Schema Information
#
# Table name: invoices
#
#  id         :integer          not null, primary key
#  due_date   :datetime         not null
#  creator_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Invoice < ActiveRecord::Base
  after_create :set_assigned_to_id, :if => lambda {|obj| obj.assigned_to_ids.present? }

  after_save :add_invoice_note, :if => lambda {|obj| obj.invoice_note.present? }
             
  attr_accessor :assigned_to_ids, :invoice_note

  audited
  acts_as_paranoid
  
  validates(
    :creator_id,
    :customer_id,
    :invoice_number,
    :invoice_date,
    :due_date,
    presence: true
  )

  belongs_to :customer, class_name: 'Customer'
  belongs_to :creator, class_name: 'User'
  belongs_to :location, class_name: 'Location'
  belongs_to :department, class_name: 'Department'
  belongs_to :payment_term, class_name: 'Term'
  belongs_to :organization

  has_one    :attachment, as: :referenceable

  has_many   :invoice_items
  has_many   :approvals, as: :approvable
  has_many   :notes, as: :noteable
  # has_many :invoice_approvals

  has_and_belongs_to_many :invoice_payments

  accepts_nested_attributes_for :invoice_items

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << [
        "id",
        "customer_name",
        "invoice_number",
        "invoice_date",
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
      all.each do |invoice|
        csv << [
          invoice.id,
          invoice.customer.name,
          invoice.invoice_number,
          invoice.invoice_date.strftime("%d %B %Y"),
          invoice.due_date.strftime("%d %B %Y"),
          invoice.due_amount,
          invoice.payment_term.try(:name),
          invoice.location.try(:name),
          invoice.department.try(:name),
          invoice.po_number,
          invoice.po_number,
          invoice.sales_rep,
          invoice.created_at.strftime("%d %B %Y"),
          invoice.updated_at.strftime("%d %B %Y")
        ]
      end
    end
  end

  def status_check
    status_array = self.approvals.map(&:status).uniq 
    if status_array.length == 1
        if status_array[0] == "Approved"
          self.received = false
          self.save
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
      self.received = nil 
      self.save 
  end

  def add_invoice_note
     usr_id = self.creator.id
     org_id = self.organization.id
     self.notes.create(creator_id: usr_id, organization_id: org_id, body: invoice_note)
  end

end
