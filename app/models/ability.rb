class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
      # if user.is_admin?

          # can :manage, :all
        if user.has_current_role? :admin
          can :manage, :all 
            
      elsif user.has_current_role? :accountant
        current_organization = Organization.find(user.current_organization_id)
        under_organization_users = current_organization.all_organization_users.map(&:id)
        can :manage, Invoice, creator_id: under_organization_users
        can [:new, :create], Invoice
        can :manage, [Customer, Vendor], organization_id: user.current_organization_id
        cannot :manage, OrganizationUsersController
        cannot :manage, OrganizationsController
      elsif user.has_current_role? :payer
        cannot :manage, OrganizationUsersController
        cannot :manage, OrganizationsController
      elsif user.has_current_role? :approver
        cannot :manage, OrganizationUsersController
        cannot :manage, OrganizationsController
      elsif user.has_current_role? :clerk
        cannot :manage, OrganizationUsersController
        cannot :manage, OrganizationsController
      else
        cannot :manage, :all
      end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
