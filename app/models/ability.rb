class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    if user.role == 'admin'
      can :delete, Post
      can :delete, Comment
    else
      can :delete, Post, user_id: user.id
      can :delete, Comment, user_id: user.id
    end
  end
end
