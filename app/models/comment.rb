class Comment < ApplicationRecord
  validates :message, presence: true,
    length: {maximum: Settings.comment.maximum_message_length}

  belongs_to :user
  belongs_to :product

  def user_name
    user ? user.name : "Unknow"
  end
end
