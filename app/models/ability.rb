class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)

    can :read, :all # start by defining rules for all users, also not logged ones
    return unless user.present?

    can :manage, Post, author_id: user.id # if the user is logged in can manage it's own posts
    can :manage, Comment, author_id: user.id
    can :manage, Like, author_id: user.id
    return unless user.role == 'admin'

    can :manage, :all # finally we give all remaining permissions only to the admins

    # if user.admin?
    #   can :manage, :all
    # else
    #   can :manage, User, user
    # end
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
