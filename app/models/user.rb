class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true

  def to_s
    name
  end

  def received_messages
    Message.where(receiver_id: id).order('created_at ASC') 
  end

  def list_sent_messages
    Message.where(sender_id: id)
  end
end
