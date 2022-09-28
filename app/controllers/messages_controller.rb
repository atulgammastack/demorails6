class MessagesController < ApplicationController
  protect_from_forgery
  def new
    @message = Message.new
    @messages = current_user.messages.all
  end

  def create
    @conversation = Conversation.find(params[:conversation_id])
   	@message = @conversation.messages.new(msg_params)
   	@message.user_id = current_user.id
    if @message.save!
      ActionCable.server.broadcast "room_channel", user: @message.user.username,
                                      content: @message.content, previous_messages: @messages
    end
  end

  private
  def msg_params
    params.require(:message).permit(:content)
  end
end
