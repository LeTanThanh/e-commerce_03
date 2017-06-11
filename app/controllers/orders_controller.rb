class OrdersController < ApplicationController
  include CartHelper

  before_action :verify_login_user!, only: :show

  def index
    @orders = current_user.orders.select(:id, :total_price, :status, :created_at)
      .order(created_at: :desc)
      .paginate page: params[:page], per_page: Settings.will_paginate.per_page_order
  end

  def create
    order_details = load_order_details_in_cart current_user.id
    order_details.each do |order_detail|
      unless order_detail.product_available? order_detail.quantity
        order_fail
        return
      end
    end
    order = Order.create user: current_user
    order_details.each do |order_detail|
      price = order_detail.product_price
      order_detail.update_attributes order: order, price: price
    end
    order_success
  end

  private

  def order_fail
    flash.now[:danger] = t "flash.danger.can_not_order_now"
    respond_to do |format|
      format.js do
        render json: {
          order_success: false,
          html_flash: render_to_string(partial: "/layouts/flash", local: {flash: flash})
        }
      end
    end
  end

  def order_success
    flash.now[:success] = t "flash.success.order_success"
    respond_to do |format|
      format.js do
        render json: {
          order_success: true,
          html_flash: render_to_string(partial: "/layouts/flash", locals: {flash: flash})
        }
      end
    end
  end
end
