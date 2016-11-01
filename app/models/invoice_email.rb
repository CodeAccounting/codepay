class InvoiceEmail < ActiveRecord::Base
	validates :invoice_id, :sender_id, presence: true

  belongs_to :sender, class_name: 'User'
  belongs_to :invoice

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << [
        "id",
        "sent_to",
        "sent_at",
        "invoice_id"
      ]
      all.each do |email|
        csv << [
          email.id,
					email.to_email,
					email.created_at.strftime("%l:%M%p [ %d %B %Y ]"),
					email.invoice_id

        ]
      end
    end
  end
end
