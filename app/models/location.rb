class Location < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
	
	belongs_to :user
end