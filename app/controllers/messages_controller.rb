class MessagesController < ApplicationController
  def show
    @message = Message.find(params[:id])
    if @message.presence
      # update the status from unread to read
      # 1: Read
      # Other value is unread :)
      @message.status = 1
      @message.save!
    end
  end

  def index
    if current_user.presence
      @messages = current_user.received_messages
    else
      @messages = []
    end
  end

  def new
    @message = Message.new
    @my_friends = Array.new

    friends = Friendship.where :user_id => current_user.id
    if friends.empty? == false
      friends.each do |item|
        friend_info = User.find_by_id(item.friend_id)
        @my_friends.push(friend_info) 
      end
    end
  end

  def create
  end
end
