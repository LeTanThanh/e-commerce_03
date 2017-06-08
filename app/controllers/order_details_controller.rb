class OrderDetailsController < ApplicationController
  def get_product_status
    order_detail = OrderDetail.new order_detail_params
    respond_to do |format|
      format.js do
        render json: {
          product_status: order_detail.product_status
        }
      end
    end
  end

  private

  def order_detail_params
    params.permit :product_id, :quantity
  end
end
