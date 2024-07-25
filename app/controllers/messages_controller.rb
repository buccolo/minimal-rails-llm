class MessagesController < ApplicationController
  before_action :set_chat

  def create
    @chat.messages.create!(message_params)
    StreamResponsesJob.perform_later(@chat)
    redirect_to @chat # TODO(bruno): use turbostream instead of redirect
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
