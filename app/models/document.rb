class Document < ApplicationRecord
  has_one_attached :file
  has_many :embeddings
end
