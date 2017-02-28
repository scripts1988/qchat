class MessagesController < ApplicationController
  def index
    if current_user.presence
      @messages = current_user.received_messages
    else
      @messages = []
    end
  end
end
