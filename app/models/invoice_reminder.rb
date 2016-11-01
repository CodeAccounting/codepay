# == Schema Information
#
# Table name: invoice_reminders
#
#  id         :integer          not null, primary key
#  invoice_id :integer          not null
#  sent_at    :datetime         not null
#  sender_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class InvoiceReminder < ActiveRecord::Base
  validates :sent_at, :invoice, :sender, presence: true

  belongs_to :sender, class_name: 'User'
  belongs_to :invoice

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << [
        "Sent To",
        "Sent At",
        "Invoice Id"
      ]
      all.each do |reminder|
        csv << [
          reminder.sent_to,
					reminder.created_at.strftime("%l:%M%p [ %d %B %Y ]"),
					reminder.invoice_id
        ]
      end
    end
  end
end