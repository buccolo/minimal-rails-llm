class LLM
  attr_reader :chat

  TEMPERATURE = 0.7 # Feeling Hot Hot Hot

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
        temperature: TEMPERATURE
      }
    )

    response.dig('choices', 0, 'message', 'content')
  end

  def call_async!(stream)
    client.chat(
      parameters: {
        model: 'gpt-4o-mini',
        messages: [pre_prompt, *messages],
        temperature: TEMPERATURE,
        stream: # response will be streamed to this proc
      }
    )
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
