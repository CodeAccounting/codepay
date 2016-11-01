class Note < ActiveRecord::Base

	belongs_to :noteable, polymorphic: true
	belongs_to :creator, class_name: 'User'
	belongs_to :organization
end
