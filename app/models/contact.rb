# == Schema Information
#
# Table name: contacts
#
#  id                 :integer          not null, primary key
#  first_name         :string           not null
#  last_name          :string           not null
#  email              :string           not null
#  payment_info_email :string
#  payment_info_phone :string
#  phone              :string
#  fax                :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  organization_id    :integer
#

class Contact < ActiveRecord::Base
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  def full_name
    "#{ first_name } #{ last_name }"
  end
end
