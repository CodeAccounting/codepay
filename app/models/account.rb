# == Schema Information
#
# Table name: accounts
#
#  id               :integer          not null, primary key
#  tax_id           :string           not null
#  is_vendor_1099   :boolean          default(FALSE), not null
#  account_number   :string           not null
#  vendor_since     :date
#  lead_time        :integer          default(0), not null
#  payment_terms    :string
#  combine_payments :boolean          default(FALSE), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Account < ActiveRecord::Base
  validates :account_number, :tax_id, presence: true
end
