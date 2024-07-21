class MessagesController < ApplicationController
  before_action :set_chat

  def create
    @message = @chat.messages.create!(message_params)
    llm_message = LLM.new.chat(@message.content)
    @chat.messages.create!(role: :assistant, content: llm_message)

    redirect_to @chat
  end

  private

  # Only allow a list of trusted parameters through.
  def message_params
    params.require(:message).permit(:content)
  end

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end
end
