class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


    def has_current_role?(admin_role)
    	role == admin_role.to_s
         # Admin.find_by(id: id, role: role.to_s).present?
    end      
end
