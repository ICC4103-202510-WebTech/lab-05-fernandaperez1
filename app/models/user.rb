class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates_presence_of :email, :first_name, :last_name
  validates :email, uniqueness: true

  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id", dependent: :destroy
  has_many :received_messages, class_name: "Message", foreign_key: "recipient_id", dependent: :destroy
  def messages
    Message.where("sender_id = ? OR recipient_id = ?", id, id)
  end
  def admin?
    self.admin
  end
  has_many :sent_chats,     class_name: 'Chat', foreign_key: :sender_id,   dependent: :destroy
  has_many :received_chats, class_name: 'Chat', foreign_key: :receiver_id, dependent: :destroy
  validates :email, presence: true, uniqueness: true
  has_many :chat_users, dependent: :destroy
  has_many :chats, through: :chat_users
end
