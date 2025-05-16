class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  validates_presence_of :body
  validates :body, presence: true

end
