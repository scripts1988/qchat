class MessagesController < ApplicationController
  def show
    @message = Message.find(params[:id])
  end

  def index
    if current_user.presence
      @messages = current_user.received_messages
    else
      @messages = []
    end
  end
end
