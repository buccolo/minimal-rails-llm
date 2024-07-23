class LLM
  attr_reader :chat

  PRE_PROMPT = <<~STR.freeze
    You're a helpful assistant.
  STR

  def initialize(chat:)
    @chat = chat
  end

  def call!
    response = client.chat(
      parameters: {
        model: 'gpt-4o-mini',
        messages: [pre_prompt, *messages],
        temperature: 0.7
      }
    )
    response.dig('choices', 0, 'message', 'content')
  end

  private

  def messages
    chat.messages.map do |message|
      { role: message.role, content: message.content }
    end
  end

  def pre_prompt
    { role: :system, content: PRE_PROMPT }
  end

  def client
    @client ||= OpenAI::Client.new
  end
end
