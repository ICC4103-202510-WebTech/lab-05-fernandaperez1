class User < ApplicationRecord
  validates_presence_of :email, :first_name, :last_name
  validates :email, uniqueness: true

  has_many :messages, dependent: :destroy
  has_many :sent_chats,     class_name: 'Chat', foreign_key: :sender_id,   dependent: :destroy
  has_many :received_chats, class_name: 'Chat', foreign_key: :receiver_id, dependent: :destroy
  validates :email, presence: true, uniqueness: true

end
