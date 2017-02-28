class Message < ApplicationRecord
  def get_sender
    User.find(sender_id)
  end
end
