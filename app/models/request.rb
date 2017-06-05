class Request < ApplicationRecord
  enum request_status: [:waiting, :accept, :reject]

  validates :content, presence: true,
    length: {maximum: Settings.request.maximum_length_content}
  validates :status, numericality: {only_integer: true,
    greater_than_or_equal_to: Settings.request.min_status,
    less_than_or_equal_to: Settings.request.max_status}

  belongs_to :user
end
