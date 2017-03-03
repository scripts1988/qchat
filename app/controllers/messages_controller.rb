class MessagesController < ApplicationController
  def show
    if current_user.presence
      @message = Message.find(params[:id])
      if @message != nil
        if @message.receiver_id == current_user.id
          # update the status from unread to read
          @message.increment!(:status)
          if @message.status >= 2
            flash[:error] = "This message is read only once"
            @message = nil
          end
        else
          flash[:error] = "Permission denined"
          @message = nil
        end
      end
    end
  end

  def index
    if current_user.presence
      @messages = current_user.received_messages
    else
      @messages = []
    end
  end

  def sent
    if current_user.presence
      @sent_messages = current_user.list_sent_messages 
    else
      @sent_messages = []
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
    @message.status = 0
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
