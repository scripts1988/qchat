class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true

  def to_s
    name
  end

  def just_my_friend
    my_friends = Friendship.where(user_id: current_user.id)
    if my_friends.empty? == false
      raise 'Here'
    end
  end

  def received_messages
    Message.where(receiver_id: id).order('created_at ASC') 
  end
end
