class Message < ApplicationRecord
  validates :sender_id, :receiver_id, presence: true

  def get_sender
    User.find(sender_id)
  end
end
