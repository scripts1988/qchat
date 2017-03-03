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
    @message = Message.new(message_params)
    @message.sender_id = current_user.id

    respond_to do |format|
      if @message.save
        format.html { redirect_to root_path, notice: 'Message was successfully sent.' }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end 
  end

  private
  def message_params
    params.require(:message).permit(:subject, :body, :receiver_id)
  end

end
