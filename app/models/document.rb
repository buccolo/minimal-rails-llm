class Document < ApplicationRecord
  has_one_attached :file
  has_many :embeddings

  # TODO: doc.embeddings.nearest_neighbors(:embedding, embedding, distance: :cosine)
end
