class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  delegate :picture, :name, :category_name, :available?, :status, :price, :id,
    to: :product, prefix: true
end
