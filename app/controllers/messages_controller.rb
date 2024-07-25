class MessagesController < ApplicationController
  before_action :set_chat

  def create
    @chat.messages.create!(message_params)
    assistant_message = @chat.messages.create(role: :assistant, content: '...')
    StreamResponsesJob.perform_later(@chat, assistant_message)
    render turbo_stream: turbo_stream.replace(@chat, partial: 'chats/chat', locals: { chat: @chat })
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end
end
