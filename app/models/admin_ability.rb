# in models/admin_ability.rb
class AdminAbility
  include CanCan::Ability
  def initialize(admin)

  	if admin.has_current_role? :Admin
          can :manage, :all 
            
    elsif admin.has_current_role? :Administrative_Assistant
	  	cannot :manage, Admins::BillPayRequestsController
      # cannot :manage, Admins::NewsController
      can [:show, :index], Admins::NewsController
      cannot [:new, :create, :delete], Admins::NewsController
      cannot :manage, Admins::AdminUsersController
	    # current_organization = Organization.find(user.current_organization_id)
	    # under_organization_users = current_organization.all_organization_users.map(&:id)
	    # can :manage, Invoice, creator_id: under_organization_users
	    # can [:new, :create], Invoice
	    # can :manage, [Customer, Vendor], organization_id: user.current_organization_id
	    # cannot :manage, OrganizationUsersController
	    # cannot :manage, OrganizationsController
    elsif admin.has_current_role? :Data_Engineer
        cannot :manage, Admins::ReportsController
        cannot :manage, Admins::BillPayRequestsController
        can [:show, :index], Admins::NewsController
        cannot [:new, :create, :delete], Admins::NewsController
        # can [:show], Admins::AdminUsersController
        # cannot [:new, :create, :delete], Admins::AdminUsersController
        # debugger
        cannot :index, Admins::AdminUsersController 
    end
  end
end