# == Schema Information
#
# Table name: organization_users
#
#  id              :integer          not null, primary key
#  organization_id :integer
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class OrganizationUser < ActiveRecord::Base
  validates :user, :organization, presence: true
  validates :user_id, uniqueness: { scope: :organization_id }

  belongs_to :user
  belongs_to :organization
end
