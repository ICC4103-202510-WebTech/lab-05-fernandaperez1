class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    if user.admin?
      can :manage, :all
    else
      can [:read, :update, :destroy], Message, sender_id: user.id
      can :create, Message

      can [:read, :update, :destroy], Chat do |chat|
        chat.sender_id == user.id || chat.receiver_id == user.id
      end
      can :create, Chat

      can [:read, :update], User, id: user.id
    end
  end
end
