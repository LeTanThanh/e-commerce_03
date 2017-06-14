class Admin::OrdersController < ApplicationController
  before_action :verify_login_user!, :verify_admin!

  def index
    user = params[:user]
    status = params[:status]

    @orders = Order.search(user, status).select(:id, :user_id, :status,
      :total_price, :created_at).order(created_at: :desc)
      .paginate page: params[:page], per_page: Settings.will_paginate.per_page

    respond_to do |format|
      format.js do
        render json: {
          html_order_table: render_to_string(partial: "admin/orders/order_table",
            locals: {orders: @orders}),
          html_order_paginate: render_to_string(partial: "admin/orders/order_paginate",
            locals: {orders: @orders})
        }
      end
      format.html do
        render :index
      end
    end
  end

  def update
    order_id = params[:order_id]
    status = params[:status]
    order = Order.find_by id: order_id

    if order.update_attributes status: status
      flash.now[:success] =  t "flash.success.update_order_status_success"
      respond_to do |format|
        format.js do
          render json: {
            update_status_success: true,
            html_flash: render_to_string(partial: "layouts/flash",
              locals: {flash: flash})
          }
        end
      end
    else
      flash.now[:danger] = t "flash.danger.update_order_status_fail"
      respond_to do |format|
        format.js do
          render json: {
            update_status_success: false,
            html_flash: render_to_string(partial: "layouts/flash",
              locals: {flash: flash})
          }
        end
      end
    end
  end
end
