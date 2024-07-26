class Embedding < ApplicationRecord
  belongs_to :document

  # pgvector states cosine similarity should be `1 - embedding <=>`,
  # but not having the `1 - ` seems better. Is it just flipped around?
  # See: https://github.com/pgvector/pgvector
  scope :cosine_similarity, ->(embedding) { order(Arel.sql("embedding <=> '#{embedding}'")).first }
end
