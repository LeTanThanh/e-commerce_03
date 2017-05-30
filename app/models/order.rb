class Order < ApplicationRecord
  enum order_status: [:inprogress, :sending, :done, :cancel]

  belongs_to :user
  has_many :order_details, dependent: :destroy
end
