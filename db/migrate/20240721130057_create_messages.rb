class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages, id: :uuid do |t|
      t.references :chat, null: false, foreign_key: true, type: :uuid
      t.integer :role
      t.text :content

      t.timestamps
    end
  end
end
