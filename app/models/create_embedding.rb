class CreateEmbedding
  def call(input)
    # https://platform.openai.com/docs/guides/embeddings/embedding-models
    response = client.embeddings(
      parameters: {
        model: 'text-embedding-3-small',
        input:
      }
    )

    puts response.dig('data', 0, 'embedding')
  end

  private

  def client
    @client ||= OpenAI::Client.new
  end
end
