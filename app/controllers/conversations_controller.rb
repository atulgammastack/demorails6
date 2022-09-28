class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = Conversation.involving(current_user).order("created_at DESC")
  end

  def create
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
    else
      @conversation = Conversation.create(conversation_params)
    end
    redirect_to  conversation_path(@conversation)
  end

  def show
    @conversation = Conversation.find(params[:id])
    @reciever = participant(@conversation)
    @messages = @conversation.messages
    @message = Message.new()
  end

  private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

  def participant(conversation)
    current_user == conversation.recipient ? conversation.sender : conversation.recipient
  end
end
