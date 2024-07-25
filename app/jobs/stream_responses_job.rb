class StreamResponsesJob < ApplicationJob
  queue_as :default

  def perform(chat, message)
    full_content = ''
    stream = proc do |chunk, _bytesize|
      full_content << chunk.dig('choices', 0, 'delta', 'content').to_s
      message.update(content: full_content)
      Turbo::StreamsChannel.broadcast_replace_to(chat, target: message,
                                                       partial: 'messages/message',
                                                       locals: { message: })
    end

    LLM.new(chat:).call_async!(stream)
  end
end
