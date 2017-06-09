class OrderDetailsController < ApplicationController
  include CartHelper

  def get_product_status
    order_detail = OrderDetail.new order_detail_params
    respond_to do |format|
      format.js do
        render json: {
          product_status: order_detail.product_status(order_detail.quantity)
        }
      end
    end
  end

  def get_total_price
    @order_details = load_order_details_in_cart current_user.id
    total_price = total_price @order_details
    respond_to do |format|
      format.js do
        render json: {
          total_price: ActionController::Base.helpers.number_to_currency(total_price,
          precision:0, unit: t("cart.show.unit"), format: t("cart.show.format"))
        }
      end
    end
  end

  private

  def order_detail_params
    params.permit :product_id, :quantity
  end
end
