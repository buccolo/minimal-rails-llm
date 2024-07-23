class Message < ApplicationRecord
  belongs_to :chat

  enum role: {
    system: 0,
    user: 1,
    assistant: 2
  }, _default: :user

  def role_emoji
    case role.to_sym
    when :assistant then '🤖'
    when :user then '🧑'
    when :system then '⚡'
    end
  end
end
