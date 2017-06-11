class Order < ApplicationRecord
  enum order_status: [:inprogress, :sending, :done, :cancel]

  belongs_to :user
  has_many :order_details, dependent: :destroy

  validates :status, numericality: {greater_than_or_equal_to: 0, less_than: Order.order_statuses.size}
end
