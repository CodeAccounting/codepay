class InvoicePayment < ActiveRecord::Base
    # after_create :update_invoice_status

	validates(
    :date,
    :payment_method,
    :payment_account,
    :payment_amount,
    presence: true
  )

	belongs_to :creator, class_name: 'User'
	belongs_to :organization

    has_and_belongs_to_many :invoices

	# belongs_to :invoice, class_name: 'Invoice'

    def update_invoice_status
        invoices = self.invoices
        invoices.each do |invoice|
         invoice.received = true
         invoice.save
        end
    end
end
