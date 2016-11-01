class InvoiceItem < ActiveRecord::Base

	belongs_to :invoice
	belongs_to :location

	belongs_to :item
	belongs_to :tax
	# validates :invoice_id, :name, :quantity, :amount, presence: true
end
