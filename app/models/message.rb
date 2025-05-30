class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  belongs_to :chat
  validates_presence_of :body
  validates :body, presence: true

end
