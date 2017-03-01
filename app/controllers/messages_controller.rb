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
end
