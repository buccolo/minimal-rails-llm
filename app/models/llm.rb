class LLM
  def chat(message)
    response = client.chat(
      parameters: {
        model: 'gpt-4o-mini',
        messages: [
          # TODO: Add system pre-prompt
          # TODO: Add previous messages in thread here
          { role: 'user', content: message }
        ],
        temperature: 0.7
      }
    )
    response.dig('choices', 0, 'message', 'content')
  end

  private

  def client
    @client ||= OpenAI::Client.new
  end
end
