class Chat < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: :sender_id
  belongs_to :receiver, class_name: 'User', foreign_key: :receiver_id
  has_many :messages, dependent: :destroy
  has_many :chat_users
  has_many :users, through: :chat_users

  after_create :add_users_to_chat
  after_create :assign_users
  attr_accessor :user_ids_to_add
  validates_presence_of :sender_id, :receiver_id
  validate :distinct_participants
  def assign_users
    chat_users.create(user_id: sender_id)
    chat_users.create(user_id: receiver_id)
  end
  private

  def distinct_participants
    return unless sender_id == receiver_id

    errors.add(:receiver_id, 'no puede ser igual al remitente')
  end

  def add_users_to_chat
    if user_ids_to_add.present?
      user_ids_to_add.each do |user_id|
        chat_users.create(user_id: user_id)
      end
    else
    end
  end
end
