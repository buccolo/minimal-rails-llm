class CreateEmbeddings < ActiveRecord::Migration[7.1]
  def change
    create_table :embeddings, id: :uuid do |t|
      t.references :document, null: false, foreign_key: true, type: :uuid
      t.text :context
      t.vector :embedding, limit: 1536 # dimensions

      t.timestamps
    end
  end
end
