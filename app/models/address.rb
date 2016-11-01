# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  address1   :string           not null
#  address2   :string
#  city       :string           not null
#  state      :string           not null
#  zip        :string           not null
#  country    :string           default("US"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Address < ActiveRecord::Base
  # validates :address1, :city, :state, :zip, :country, presence: true
  
  def full
  	"#{address1}, #{address2}, #{city}, #{state}, #{zip}, #{country}"
  end

end
