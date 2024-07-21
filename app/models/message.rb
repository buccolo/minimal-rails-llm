class Message < ApplicationRecord
  belongs_to :chat

  enum role: {
    system: 0,
    user: 1,
    assistant: 2
  }, _default: :user
end
