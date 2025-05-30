class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can [:read, :update, :destroy], Message, user_id: user.id
    can :create, Message

    can [:read, :update, :destroy], Chat, sender_id: user.id
    can [:read, :update, :destroy], Chat, receiver_id: user.id
    can :create, Chat

    can [:read, :update], User, id: user.id
  end
end
