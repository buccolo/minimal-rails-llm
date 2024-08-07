# See more: https://platform.openai.com/docs/guides/embeddings/embedding-models
class GenerateEmbeddingsJob < ApplicationJob
  queue_as :default

  # The maximum amount of tokens for each embedding is 8191.
  # One token represents about 3/4 of a word, so we have a maximum of ~6100 words.
  # We'll use 1000 words so we can see more embedding being created.
  #
  # See https://github.com/IAPark/tiktoken_ruby for more precise token counting.
  EMBEDDING_SIZE_IN_WORDS = 1000

  def perform(document)
    # Great advice on how to slice and create chunks over here:
    # https://www.timescale.com/blog/postgresql-as-a-vector-database-create-store-and-query-openai-embeddings-with-pgvector/
    #
    # For the sake of this exercise, we're following a very naive approach:
    content_of(document).split.each_slice(EMBEDDING_SIZE_IN_WORDS) do |words|
      embedding_content = words.join(' ')

      response = client.embeddings(parameters: {
                                     model: 'text-embedding-3-small',
                                     input: embedding_content
                                   })

      embedding = response.dig('data', 0, 'embedding')
      document.embeddings.create!(context: embedding_content, embedding:)
    end
  end

  private

  def content_of(document)
    document.file.blob.download
  end

  def client
    @client ||= OpenAI::Client.new
  end
end
