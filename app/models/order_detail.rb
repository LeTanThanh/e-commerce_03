class OrderDetail < ApplicationRecord
  after_save :update_order_total_price, :update_product_order_quantity

  belongs_to :order
  belongs_to :product

  delegate :picture, :name, :category_name, :available?, :status, :price, :id,
    to: :product, prefix: true

  private

  def update_order_total_price
    total_price = order.total_price + price * quantity
    order.update_attributes total_price: total_price
  end

  def update_product_order_quantity
    product_quantity = product.quantity - quantity
    product.update_attributes quantity: product_quantity
  end
end
