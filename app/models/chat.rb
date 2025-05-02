class Chat < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: :sender_id
  belongs_to :receiver, class_name: 'User', foreign_key: :receiver_id
  has_many :messages, dependent: :destroy

  validates_presence_of :sender_id, :receiver_id
  validate :distinct_participants

  private

  def distinct_participants
    return unless sender_id == receiver_id

    errors.add(:receiver_id, 'no puede ser igual al remitente')
  end
end
