class Request < ApplicationRecord
  enum request_status: [:waiting, :accept, :reject]

  belongs_to :user
end
